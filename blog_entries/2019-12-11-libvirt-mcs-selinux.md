### Applying SELinux Tags To Allow Cross-VM Disk Access

December 11, 2019

Fedora uses SELinux's Multi Category Security to restrict VMs from accessing other VMs backing disks. Each VM is assigned a randomized category number when starting. When accessing a VM disk file from another running VM, such as by sharing a directory, an error similar to the following is logged by systemd:

```
audit[26742]: AVC avc:  denied  { read } for  pid=26742 comm="worker" name="testvm.qcow2" dev="dm-6" ino=24642243 scontext=unconfined_u:unconfined_r:svirt_t:s0:c501,c650 tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=0
```

To allow a VM access to other VMs backing disks, you can apply a SELinux tag to the running qemu process allow access to all disks. To allow a VM named `backup` to have read and write access to other VM backing files, run `virsh editxml --domain backup` and insert the following before `</domain>`:

```
<seclabel type='static' model='selinux' relabel='yes'>
  <label>unconfined_u:unconfined_r:svirt_t:s0:c0.c1023</label>
</seclabel>
```

Ideally, a custom SELinux policy should be created to allow read-only access to backing disks. However, mounting backing disk files as readonly within a VM through libvirt may be an acceptable  compromise on complexity and in-depth security for your scenario.
