### .NET Deserilization Gadgets

December 25, 2019

The use of `BinaryFormatter` in .NET applications often leads to Remote Code Execution quite easily. See <https://github.com/pwntester/ysoserial.net> for example gadgets.

When testing the TypeConfuseDelegate payload in your own project, a couple of exceptions may be thrown:

* 'Object must implement IConvertible' - This occurs when the appropriate deserialization types can not be found. Check to ensure you are compiling with a .NET Framework project to instead of .NET Core.

* "System.IO.FileNotFoundException: 'Could not load file or assembly 'System' or one of its dependencies. The system cannot find the file specified.'" - An easy way to fix the runtime error for your Proof of Concept is by adding a `System` reference to the project, and setting `Copy Local` to `True`. This causes the `System.dll` file to copied to the build directory.

Often developers try to re-mediate Deserialization bugs by whitelisting which types can be deserialized. In .NET applications, the `System` assembly gets whitelisted often. However, known remote code execution gadgets exist in `System`, and can be leveraged to gain remote code execution. 

A recommended fix is to use a Deserialization framework that doesn't allow arbitrary types to be deserialized, such as JSON. 
