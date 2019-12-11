### Applying SELinux Tags To Specific KVM VM Process To Allow Access Of Another VM's Backing Disk

December 11, 2019

Fedora uses SELinux's Multi Category Security to restrict VM's from accessing another VM's backing disks. Each VM is assigned a randomized category number when starting. To allow a VM to read another VM's backing disk, you can override the tag of the process to allow access to all containers of a specific type.


To allow a vm named `backup` to have read and write access to other VM backing files, run `virsh editxml --domain backup` and insert the following before `</domain>`.

```
<seclabel type='static' model='selinux' relabel='yes'>
  <label>unconfined_u:unconfined_r:svirt_t:s0:c0.c1023</label>
</seclabel>
```

Ideally, for a backup system a custom selinux policy should be created to allow read-only access to backing disks. However, mounting backing disk files as readonly within a VM through libvirt can be considered a compromise on complexity and in-depth security.
