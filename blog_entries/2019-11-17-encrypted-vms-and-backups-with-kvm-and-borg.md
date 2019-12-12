### Creating and backing up security sensitive VMs using KVM and Borg

Nov 17, 2019

It's Thursday night. You've been hacking away at a web app all week. All of a sudden your laptop turns off because you forgot to plug in the power cord. No bigge you think. You plug your laptop in, boot it up, and start the VM you've been using. *Crap*, you sigh to yourself, as you realize your proxy project file is corrupted. You start hunting for the bugs you've already discovered, muttering to yourself you should have had a backup plan in place.

Sound familiar? Hopefully not! But if so, let's see how we can mitigate this from occurring.

At its core, we need a way to backup VMs which have an encrypted data store. VM Backups should occur behind the scenes, and downtime should be minimum (under a second at most). Additionally, we are aiming for crash consistency.  There are a few ways to achieve this, but this is one of the less complex methods in my opinion: 

* VMs should use two separate disk files. The first file is for storing root, boot, home,var, etc. The second file is just for swap. We don't back up the swap disk file  as it's highly volatile and not necessary. Our backups would grow quite large if we backed up swap every night.

* We use virsh's snapshot-create-as feature to create copy-on-write snapshots, and merge them back in with virsh blockcommit.

* We use LUKS inside the VM for encryption. From the hypervisor perspective, this simplifies VM provisioning and the backup process for a few reasons.  For instance, the hypervisor doesn't need to know how to decrypt the VM's backend store to start the VM, or how to securely store temporary snapshots. VMs leveraging encryption which need to be started in an automated fashion can use network bound disk encryption methods. Additionally, each VM should have it's own master encryption key, to mitigate risk of a key being compromised (ie, if a VM is exploited and root is obtained within the VM.). 

* We use sparse qcow2 files to allow disk files to grow when needed. This can lead to over-committing disk space, but it's a trade-off that allows you to re-use a template vm for easier provisioning. The backup process can also perform de-duplication for unused blocks, as they will appear as a bunch of zeros in sparse images.
    
* To keep the hypervisor vanilla as possible, a  separate VM for backing up files  is used. The files to be backed up can be mounted as readonly within the backup VM.  Note as the VM files are encrypted, the risk of the backup VM accidentally backing up sensitive data is mitigated. For additional security,  VM images can be signed, to verify they have not been tampered with.

* If necessary, a script is run within the VM before the snapshot is taken to close applications which don't support crash-consistency. After the snapshot is made, the application is re-started. The script can be triggered through SSH for instance.

* AMD's Secure Memory Encryption and Secure Encrypted Virtualisations can be used to protect against physical attacks, and mitigate the risk of a malicious attack carried out in the hypervisor to read the VM's memory. Ie, the hypervisor would only see encrypted data if attempting to read the guest VM's memory directly. I imagine a backdoor can be placed on a system however to defeat the mitigation.
