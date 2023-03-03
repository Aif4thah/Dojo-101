/* C# basics

Compiler le code

installer `visual studio` ou le framework dotnet et utiliser la commande `dotnet run`

*/

//Hello world


using System; // librairie importée
using System.Collections.Generic;
using System.Net.Sockets;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
					
public class Program
{
	public static void Main(string[] args) // fonction
	{
		Console.WriteLine("Hello World");
	}
}


// saisie utilisateurs

string message = Console.ReadLine();


// condition


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


// boucle


        List<int> liste = new List<int>(){1,2,3};
		
		//classic
		foreach(var l in liste){
			Console.WriteLine(l);
		}
		
		//linq
		liste.ForEach(i => Console.WriteLine(i));



// lire un fichier

        string text = File.ReadAllText(textFile);
        Console.WriteLine(text);

// fonction async

class Program
{
    static void Main(string[] args)
    {
        Method1();
        Method2();
        Console.ReadKey();
    }

    public static async Task Method1()
    {
        await Task.Run(() =>
        {
            for (int i = 0; i < 100; i++)
            {
                Console.WriteLine(" Method 1");
                // Do something
                Task.Delay(100).Wait();
            }
        });
    }


    public static void Method2()
    {
        for (int i = 0; i < 25; i++)
        {
            Console.WriteLine(" Method 2");
            // Do something
           Task.Delay(100).Wait();
        }
    }
}


// executer des commandes système



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

// lire un fichier


string text = File.ReadAllText(textFile); 


// classes et objets


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


// TLS Sockets


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

// TLS Sockets client

                    // valider automatiquement un certificat TLS:


   public static class UClient
                        {
                            public static bool CertificateValidationCallback(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
                            {
                                //Be aware that there is no PKI, the authentication method is manual
                                X509Certificate2 cert2 = new X509Certificate2(certificate);
                                Console.ForegroundColor = ConsoleColor.Red;
                                Console.WriteLine("CN:{0}\nExpirDate:{1}\nPubKey:{2}\nThumprint:{3}\n",
                                    cert2.Issuer, cert2.GetExpirationDateString(), cert2.GetPublicKeyString(), cert2.Thumbprint);
                                Console.WriteLine("YOU HAVE FEW SECONDS TO KILL THE PROCESS AND REJECT THE RISK...");
                                Console.WriteLine("(accepted)");
                                Console.ResetColor();

                                return true;
                            }
                        }

public class Program
{
	                     
	
	public static void Main()
	{
		                TcpClient client = new TcpClient("185.87.66.119", 443);
                        var stream = client.GetStream();
                        SslStream sslStream = new SslStream(stream, false, new RemoteCertificateValidationCallback(UClient.CertificateValidationCallback));
                        sslStream.AuthenticateAsClient("client", null, System.Security.Authentication.SslProtocols.Tls12, false);
						Console.WriteLine("connected");
	}
}

// TLS Sockets server


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



// Powershell without powershell


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



// minimal API


using VulnerableWebApplication;
using System.Web;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/", () => "Hello");
app.Run("https://localhost:3000");


// crypto random

using System.Security.Cryptography;

int randvalue = RandomNumberGenerator.GetInt32(p.Length);
byte[] RandBytes = RandomNumberGenerator.GetBytes(Length);



// Encoding

                Uri.EscapeDataString(input);
                HttpUtility.UrlEncode(input);
                HttpUtility.UrlEncodeUnicode(input);
                HttpUtility.HtmlEncode(input);

private static string HexEscapeString(string str)
        {
            string hexstr = string.Empty;
            foreach (char c in str)
            {
                try { hexstr += Uri.HexEscape(c); }
                catch { hexstr += c; }               
            }
            return hexstr;
        }

        private static string AsciiEncode(string str)
        {
            string htmlASCIIEncoded = string.Empty; ;
            foreach (char c in str)
            {
                try
                {
                    int val = Convert.ToInt32(c);
                    if (val < 128) //if ASCCI not extended
                    {
                        htmlASCIIEncoded += "&#" + val.ToString() + ";";
                    }
                }
                catch { htmlASCIIEncoded += c; }
            }
            return htmlASCIIEncoded;
        }


        private static string AsciiHexEncode(string str)
        {
            string htmlASCIIHexEncoded = string.Empty; ;
            foreach (char c in str)
            {
                try
                {
                    int val = Convert.ToInt32(c);
                    if (val < 128) //if ASCCI not extended
                    {
                        htmlASCIIHexEncoded += "&#x" + val.ToString("X") + ";";
                    }
                }
                catch { htmlASCIIHexEncoded += c; }
            }
            return htmlASCIIHexEncoded;
        }




// fuzzing : mutation:



        public static string RepRandBc(string p)
        {         
            int randvalue = RandomNumberGenerator.GetInt32(p.Length);
            int randbc = RandomNumberGenerator.GetInt32(BadStrings.Output.Count);  
            
            StringBuilder sb = new StringBuilder(p);
            sb.Remove(randvalue, 1);     
            
            return sb.ToString().Insert(randvalue, BadStrings.Output[randbc]);
        }


        public static string AddRandBc(string p)
        {
            int randvalue = RandomNumberGenerator.GetInt32(p.Length);
            int randbc = RandomNumberGenerator.GetInt32(BadStrings.Output.Count);

            return p.Insert(randvalue, BadStrings.Output[randbc]);
        }

        public static string RepLine(string p)
        {
            string[] lines = p.Split('\n');
            int randvalue = RandomNumberGenerator.GetInt32(lines.Length);
            int randbc = RandomNumberGenerator.GetInt32(BadStrings.Output.Count);
            lines[randvalue] = BadStrings.Output[randbc];

            return String.Join('\n', lines);
        }


        public static string DelChar(string p)
        {
            int randvalue = RandomNumberGenerator.GetInt32(p.Length);
            StringBuilder sb = new StringBuilder(p);
            
            return sb.Remove(randvalue, 1).ToString();
        }

        public static byte[] BitFlip(byte[] bytes)
        {
            byte[] bitW = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 };

            int randvalue = RandomNumberGenerator.GetInt32(bytes.Length);
            int randbit = RandomNumberGenerator.GetInt32(bitW.Length);

            try { bytes[randvalue] += bitW[randbit]; }
            catch { bytes[randvalue] -= bitW[randbit]; }

            return bytes;
        }


        public static byte[] RepBytes(byte[] bytes)
        {

            int randLength = RandomNumberGenerator.GetInt32(1, 4);

            if(bytes.Length <= randLength)
            {
                bytes = RandomNumberGenerator.GetBytes(randLength);
            }
            else
            {
                int randvalue = RandomNumberGenerator.GetInt32(bytes.Length - randLength);
                byte[] RandBytes = RandomNumberGenerator.GetBytes(randLength);

                for (int i = 0; i < randLength; i++)
                    bytes[randvalue + i] = RandBytes[i];
            }


            return bytes;
        }


        public static string RepeatStr(string p)
        {

            StringBuilder sb = new StringBuilder(p);
            int startIndex = RandomNumberGenerator.GetInt32(sb.Length);
            
            return p + sb.ToString(startIndex, sb.Length - startIndex);
           
        }

