program fpRSS;

uses UnitRSS,
     OpenSSL;

begin
    InitSSLInterface;
    if ParamCount > 0 
        then if (checkInternet())
            then writeln(getRequest(ParamStr(1)))
            else writeln('no internet')
        else writeln('no rss url provided');
end.