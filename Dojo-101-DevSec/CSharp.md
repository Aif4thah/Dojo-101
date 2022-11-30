# C#

## Compiler le code

installer `visual studio` ou le framework dotnet et utiliser la commande `dotnet run`

## Hello world

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

## classes et objets

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

## TLS Sockets

### classes
```c#

        public static string readMsg(SslStream sslStream, TcpClient client)
        {
            byte[] buffer = new byte[client.ReceiveBufferSize];
            int bytesRead = sslStream.Read(buffer, 0, client.ReceiveBufferSize);
            return Encoding.UTF8.GetString(buffer, 0, bytesRead);
        }

        public static void sendMsg(string message, SslStream sslStream)
        {
            sslStream.Write(Encoding.UTF8.GetBytes(message), 0, Encoding.UTF8.GetBytes(message).Length);
        }

		public static void printConnection(SslStream sslStream)
        {
            Console.ForegroundColor = ConsoleColor.Red; ;
            Console.WriteLine("Cipher: {0}", sslStream.CipherAlgorithm);
            Console.WriteLine("Hash: {0}", sslStream.HashAlgorithm);
            Console.WriteLine("Key exchange: {0}", sslStream.KeyExchangeAlgorithm);
            Console.WriteLine("Protocol: {0}", sslStream.SslProtocol);
            Console.ResetColor();
        }

		public static bool CertificateValidationCallback(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
        {
            return true;
        }

```

### client

```c#
                        TcpClient client = new TcpClient(ip, port);
                        var stream = client.GetStream();
                        SslStream sslStream = new SslStream(stream, false, new RemoteCertificateValidationCallback(UClient.CertificateValidationCallback));
                        sslStream.AuthenticateAsClient("client", null, System.Security.Authentication.SslProtocols.Tls12, false);
						while (true)
                        {
							/* etc...*/
						}
```

### server

```c#
Int16 port = Int16.Parse(args[0]);
                var certificate = new X509Certificate2(args[1], args[2]);
                Console.WriteLine("<0> Server mode\n<0> Port: {0:D}", port);

                //Start Tcp Listener, wait for client and get SSL stream
                var listener = new TcpListener(IPAddress.Any, port);
                listener.Start();

                while (true)
                {
                    var client = listener.AcceptTcpClient();
                    var stream = client.GetStream();
                    SslStream sslStream = new SslStream(stream, false);
                    sslStream.AuthenticateAsServer(certificate, false, System.Security.Authentication.SslProtocols.Tls12, false);
                    
                    UServer.printConnection(sslStream);
					/* etc... */
				}
```


### Powershell without powershell

```c#
 public static string ObfuscatePwsh(string message)
        {
            string obfcmd = String.Empty;
            try
            {
                using (PowerShell ps = PowerShell.Create())
                {
                    string script = File.ReadAllText(".\\Shellingan.ps1");
                    ps.AddScript(script);
                    ps.Invoke();
                    ps.AddStatement().AddCommand("Invoke-Shellingan").AddParameter("cmd", message).AddParameter("iex", true).AddParameter("recurse", "1");
                    Collection<PSObject> results = ps.Invoke();
                    foreach (PSObject result in results)
                    {
                        obfcmd += result.ToString();
                    }
                    ps.Commands.Clear();

                }
            }
            catch(Exception e)
            {
                Console.WriteLine("{0} Exception caught.", e);
                Console.ForegroundColor = ConsoleColor.Blue;
                Console.WriteLine("<0> Obfuscation error: origninal command sended");
                obfcmd = message;
            }
            Console.ForegroundColor = ConsoleColor.Blue;
            Console.ResetColor();
            return obfcmd;

        }
```


### minimal API

```c#
using VulnerableWebApplication;
using System.Web;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/", () => "Hello");
app.Run("https://localhost:3000");

```

## crypto random

```c#

using System.Security.Cryptography;

int randvalue = RandomNumberGenerator.GetInt32(p.Length);
byte[] RandBytes = RandomNumberGenerator.GetBytes(Length);

```