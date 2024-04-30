unit UnitRSS;

{$mode objfpc}{$H+}

interface

uses 
    fpHTTPClient,
    {$IFDEF DARWIN}
    ns_url_request
    {$ELSE}
    OpenSSLSockets,
    OpenSSL
    {$ENDIF}
    //, fpJSON, JSONParser
    //, AppConfig
    ;

function getRequest(addr : String) : String;

function checkInternet() : Boolean;


implementation

uses SysUtils;

function getRequest(addr : String) : String;
{$IFDEF DARWIN}
var
    HTTP: TNSHTTPSendAndReceive;
begin
    HTTP := TNSHTTPSendAndReceive.Create;
    HTTP.Method   := 'GET';
    HTTP.Address  := addr;
    HTTP.SendAndReceive(Result);
    HTTP.Free;
end;  
{$ELSE}
begin
    Result := '{}';
    With TFPHttpClient.Create(Nil) do
        try
            //AllowRedirect:=true;
            Result := Get(addr);
            //WriteLn(ResponseStatusCode);
        finally
            Free;
        end;
end;
{$ENDIF}




function checkInternet() : Boolean;
begin
    //Result := False;
    try
        Result := (getRequest('http://www.google.com') <> '');
    except
        on E: Exception do
        begin
            Result := False;
        end;
    end;
end;

end.