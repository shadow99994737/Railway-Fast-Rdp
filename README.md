# Smooth XFCE RDP (Railway-ready)

## Kya optimize kiya gaya hai
1. **XFCE** desktop (GNOME/KDE se bohot lighter — kam RAM, kam CPU)
2. **xorgxrdp** backend — default xrdp VNC-based session se kaafi fast
3. **Compositing OFF** — window shadows, transparency, animations sab band (ye sabse zyada lag create karte hain RDP pe)
4. **Color depth 16-bit** — 32-bit ke muqable data kam bhejta hai network pe, isliye smooth feel hota hai
5. **Single workspace** — extra overhead nahi

## Login details
- Username: `rdpuser`
- Password: `rdppass123`

⚠️ Deploy karne ke baad turant password change kar lena (security ke liye).

## Railway pe deploy
```
git init
git add .
git commit -m "Smooth XFCE RDP"
git remote add origin <your-repo-url>
git push -u origin main
```
Railway dashboard me "Deploy from GitHub repo" select karo, ye repo connect karo, port `3389` expose ho jayega (Railway TCP proxy use karega).

## RDP client settings (aur bhi smooth banane ke liye)
Apne Remote Desktop app me connect karte waqt ye settings use karo:
- **Color depth**: 16-bit ya "High Color" (32-bit mat use karo)
- **Desktop background**: OFF
- **Font smoothing**: OFF
- **Menu/window animations**: OFF
- **Visual styles**: OFF (agar option mile)
- **Bitmap caching**: ON (agar option mile)

Windows ke built-in "Remote Desktop Connection" (mstsc) me: Show Options → Experience tab → "Low Speed Broadband" ya custom select karke sab effects uncheck kar do.

## Note
Railway free/hobby tier ka RAM-CPU limited hota hai — agar phir bhi lag mehsoos ho to Railway dashboard se plan ka RAM/CPU allocation badhana sabse badा fark dalta hai (software optimization ki apni limit hai).
