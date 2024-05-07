@echo off
setlocal enabledelayedexpansion

:: Lay tat ca cac adapter IPV4 cua may tinh > cho vao file ipv4.txt
netsh interface ipv4 show interfaces > ipv4.txt

:: xem tat ca cac adapter roi chuyen het sang may chu google
set /a count=0
for /f "tokens=5,* delims= " %%a in ('type ipv4.txt ^| findstr /r /v "^$"') do (
    if !count! geq 2 (

        set "adapter=%%a %%b"
        for %%A in ("!adapter!") do set "adapter=%%~A"
        rem Ngat ky tu space cuoi cung (windows ncl)
        set "lastChar=!adapter:~-1!"
        if "!lastChar!"==" " set "adapter=!adapter:~0,-1!"

        echo Dang thay doi IPv4 "!adapter!" sang Google DNS...
        :: "Preferred"
        netsh interface ipv4 set dnsserver "!adapter!" static 8.8.8.8
        :: "Alternate"
        netsh interface ipv4 add dnsserver "!adapter!" 8.8.4.4 index=2
    )
    :: Chi su dung tu dong 2 tro xuong :)
    set /a count+=1
)
del ipv4.txt
endlocal