# C#

## HELLO WORLD

```c#
using System; # librairie importée
					
public class Program
{
	public static void Main() # fonction
	{
		Console.WriteLine("Hello World");
	}
}
```

## saisie utilisateurs

```c#
string message = Console.ReadLine();
```

## condition

```c#
		//classic
		int a = 1;
		if(1 == a){
			Console.WriteLine("vrai");			
		}else{ 
			Console.WriteLine("faux");
		}
		
		// condition ternaire
		bool result = (a == 1) ? true : false;
		Console.WriteLine("{0}", result);
```

## boucle

```c#
List<int> liste = new List<int>(){1,2,3};
		
		//classic
		foreach(var i in liste){
			Console.WriteLine(i);
		}
		
		//linq
		liste.ForEach(i => Console.WriteLine(i));
```

## executer des commandes système

```c#

		string message = "cat /etc/passwd";
		int timeout = 200;
            System.Diagnostics.Process cmd = new Process();
            cmd.StartInfo.FileName = "/bin/sh";
            cmd.StartInfo.RedirectStandardInput = true;
            cmd.StartInfo.RedirectStandardOutput = true;
            cmd.StartInfo.CreateNoWindow = true;
            cmd.StartInfo.UseShellExecute = false;

                cmd.Start();
                cmd.StandardInput.WriteLine(message);
                cmd.StandardInput.Flush();
                cmd.StandardInput.Close();
                cmd.WaitForExit(timeout);
                message = cmd.StandardOutput.ReadToEnd();

		
		Console.WriteLine(message);
```

# lire un fichier

```c#
string text = File.ReadAllText(textFile); 
``` 

# classes et objets

```c#
namespace CShidori.DataHandler
{
    public class BinLoader
    {
        public byte[] DataBytes { get; set; }
        public string FileName { get; set; }

        public BinLoader(string FileName)
        {
            this.FileName = FileName;
            this.DataBytes = File.ReadAllBytes(FileName);
        }
    }
}
```

