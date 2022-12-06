# splunk in docker

https://hub.docker.com/r/splunk/splunk/

## install de docker sous debien: apt install docker.io

Download the universal forwarder image to your local Docker engine:

`$ docker pull splunk/splunk:latestUse`

 the following command to start a single instance of the Splunk Universal Forwarder:

`$ docker run -d -p 8000:8000 -e "SPLUNK_START_ARGS=--accept-license" -e "SPLUNK_PASSWORD=<password>" --name splunk splunk/splunk:latest`

Let's break down what this command does:

1. Starts a Docker container detached using the splunk/splunk:latest image.
2. Expose a port mapping from the host's 8000 to the container's 8000.
3. Specify a custom SPLUNK_PASSWORD - be sure to replace <password> with any string that conforms to the Splunk Enterprise password requirements.
4. Accept the license agreement with SPLUNK_START_ARGS=--accept-license. This must be explicitly accepted on every splunk/splunk container, otherwise Splunk will not start.
After the container starts up successfully and enters the "healthy" state, you should be able to access SplunkWeb at http://localhost:8000 with admin:<password>.



