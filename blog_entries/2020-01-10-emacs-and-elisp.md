### On Emacs 

January 10th, 2020

Over the last 20 years I've used many  environments for programming and editing files (vim, Emacs, Eclipse, NetBeans, PHPStorm, Visual Studio, just to name some). While I will use the right tool for the right job, I'm partial to Emacs.


**Emacs is easy to extend** - You can modify Emacs while it's running, within Emacs. There is no need for a separate development environment. You write some elisp and then evaluate the expressions within Emacs. There is no need to set up a project for plugin development, and no need to learn a custom language with lots of syntax. I'm not a fan of vimscript, powershell, or scala for this reason, but i digress.

**Emacs allows you to optimize your workflow** - I dislike having to switch between multiple applications, it's a waste of time. As Emacs is easy to extend, you can optimize your workflow so everything is a few keystrokes away. For projects, I manage my todo-list, program, run shell commands, and do technical writing all within Emacs. I even have grammar checking in Emacs thanks to integrating language tool.

**Emacs allows you to program using keyboard macros** - Keyboard macros allows you save keystrokes and run them later. This allows you to be really hacky and get things done quickly. Need a one-off program to save the current file, then execute a shell command? Write a macro. Need a one-off program to move the current line to a different buffer? Use a macro. Any one-off action you find repetitive and it's not wroth writing elisp for, try writing a macro instead. Keep in mind other people don't use Emacs, so for project-related repetitive operations, they should be within a build script of some sort.

Of course, there are downsides to using Emacs.

**Learning Emacs takes time** - The way I think about Emacs is it's a programming environment for itself. Key bindings are merely shortcuts to invoking  elisp functions. When you write elsip, you will have to spend time learning it's core API. Emacs introspection helps though.

**Configuring Emacs takes time** - You have to invest time to tweak Emacs the way you want it, and it's never perfect. You have to remind yourself to invest your time wisely to achieve your goals. Sometimes it's better not to modify Emacs so you can your real work done.

**Emacs is insecure** - Emacs does not verify TLS certificates by default, which is insane. Additionally its common to download packages from melpa/github to configure Emacs how you want it. As these packages are executed within Emacs, this can easily lead to malware being installed on your computer. Even worse, you essentially can't trust that what you see on the screen is actually is not is tampered with. For this reason, I review elisp which I use in my setups. Additionally, I sandbox Emacs in such a way where it would be hard for malware to exfiltrate data. 

It would be great if their was a straight forward method to  access multiple compartmentalized Emacs instances from a trusted Emacs instance. This would be useful to restrict what compromised Emacs instances can access.
