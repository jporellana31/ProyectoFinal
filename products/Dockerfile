FROM mcr.microsoft.com/powershell:latest

WORKDIR /usr/src/server/

COPY . .    

RUN pwsh -c "Install-Module 'Pode' -Force -AllowClobber"

CMD [ "pwsh", "-c", "cd /usr/src/server; ./server.ps1" ]