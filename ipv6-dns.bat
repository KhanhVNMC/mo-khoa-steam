@echo off
setlocal enabledelayedexpansion

:: Lay tat ca cac adapter IPV6 cua may tinh > cho vao file ipv6.txt
netsh interface ipv6 show interfaces > ipv6.txt

:: xem tat ca cac adapter roi chuyen het sang may chu DNS cua google
set /a count=0
for /f "tokens=5,* delims= " %%a in ('type ipv6.txt ^| findstr /r /v "^$"') do (
    if !count! geq 2 (

        set "adapter=%%a %%b"
        for %%A in ("!adapter!") do set "adapter=%%~A"
        rem Ngat ky tu space cuoi cung (windows ncl)
        set "lastChar=!adapter:~-1!"
        if "!lastChar!"==" " set "adapter=!adapter:~0,-1!"

        echo Dang thay doi IPv6 "!adapter!" sang Google DNS...
        :: "Preferred"
        netsh interface ipv6 set dnsserver "!adapter!" static 2001:4860:4860::8888
        :: Alt
        netsh interface ipv6 add dnsserver "!adapter!" 2001:4860:4860::8844 index=2
    )
    :: Nhu cai tren, dung tu dong 2 tro xuong
    set /a count+=1
)
del ipv6.txt
endlocal
