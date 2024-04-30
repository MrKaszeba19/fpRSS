program fpRSS;

uses UnitRSS
    {$IFNDEF DARWIN}
     ,OpenSSL
    {$ENDIF DARWIN}
     ,WindowManager
     //,ncurses
     ,LibPasNcurses
     ;

begin
    {$IFNDEF DARWIN}
    InitSSLInterface;
    {$ENDIF DARWIN}
    if ParamCount > 0 then 
    begin
        if (checkInternet()) then
        begin
            initscr;
            printw(PChar(getRequest(ParamStr(1)))); 
            refresh;
            getch;
            endwin;
        end else begin
            writeln('no internet');
        end;
    end else begin
        writeln('no RSS URL provided!');
    end;
end.