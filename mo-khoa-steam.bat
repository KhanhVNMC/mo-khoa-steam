@echo off

rem Kiem tra quyen ADMIN
net session >nul 2>&1
if %errorlevel% == 0 (
    title Dit con me VTC - Bam Enter de tiep tuc
) else (
    rem Hoi nguoi dung xem co muon chay chuong trinh khong
    powershell -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

rem Bat dau

rem cac hang so can thiet
set "script_dir=%~dp0"
set "dns_server=8.8.8.8"
set "v6_dns_server=2001:4860:4860::8888"

rem Description linh tinh cac thu
echo Deo an duoc xong dap do a? Lam game nhu cc xong cam me Steam
echo:
echo Steam bi cam tren cac may chu DNS (https://www.hostinger.vn/huong-dan/dns-la-gi) cua Viet Nam
echo do thang dau buoi VTC chu muu.
echo:
echo Script nay se chuyen DNS cua may tinh ban sang 8.8.8.8, DNS toan cau cua Google
echo Sau khi script nay chay xong, ban co the vao lai Steam nhu binh thuong!
echo:
echo Tac gia: Nguyen Gia Khanh

echo:
echo Bam ENTER de tiep tuc qua trinh mo khoa Steam!
pause

title Dang doi server DNS IPV4 cua ban sang Google DNS - Dit con me VTC
rem Khoi chay chuyen doi IPV4 sang DNS cua google
echo Dang chuyen IPV4 DNS sang %dns_server%...
call "%script_dir%ipv4-dns.bat"

title Dang doi server DNS IPV6 cua ban sang Google DNS - Dit con me VTC
rem Khoi chay chuyen doi IPV6 sang DNS cua google
echo Dang chuyen IPV6 DNS sang %v6_dns_server%...
call "%script_dir%ipv6-dns.bat"

title Dang hoan tat qua trinh - Dit con me VTC
echo Dang hoan tat qua trinh...
ipconfig /flushdns

rem Xong
title Bay gio ban co the vao Steam nhu binh thuong - Dit con me VTC
echo:
echo DNS da duoc chuyen sang server cua Google cho may tinh cua ban!
echo Ban co the vao duoc Steam nhu binh thuong roi!
echo:
echo #ditmevtc #tralaisteamchotao
pause
