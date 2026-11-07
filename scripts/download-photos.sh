#!/bin/bash
set -e

DIR="assets/photos/landmarks"
mkdir -p "$DIR"

UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

download_img() {
  local filename="$1"
  local url="$2"
  local target="$DIR/$filename"

  if [ -f "$target" ] && [ $(wc -c < "$target") -gt 50000 ]; then
    echo "[EXISTS] $filename ($(du -h "$target" | cut -f1))"
    return 0
  fi

  echo "[DOWNLOADING] $filename from $url..."
  if curl -s -L --connect-timeout 8 --max-time 20 -H "User-Agent: $UA" "$url" -o "$target"; then
    local size=$(wc -c < "$target" || echo 0)
    if [ "$size" -gt 10000 ]; then
      echo "[OK] $filename ($(du -h "$target" | cut -f1))"
    else
      echo "[FAIL] $filename too small ($size bytes)"
      rm -f "$target"
      return 1
    fi
  else
    echo "[ERROR] failed to download $filename"
    rm -f "$target"
    return 1
  fi
}

# 1. Eo Gió (Đã có, kiểm tra kích thước)
download_img "eo-gio.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Eo_Gi%C3%B3_-_Nh%C6%A1n_L%C3%BD.jpg/1280px-Eo_Gi%C3%B3_-_Nh%C6%A1n_L%C3%BD.jpg" || true

# 2. Tháp Đôi Quy Nhơn (Đã có)
download_img "thap-doi.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Th%C3%A1p_%C4%90%C3%B4i%2C_Quy_Nh%C6%A1n_-_43083336701.jpg/1280px-Th%C3%A1p_%C4%90%C3%B4i%2C_Quy_Nh%C6%A1n_-_43083336701.jpg" || true

# 3. Gành Đá Đĩa
download_img "ganh-da-dia.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/G%C3%A0nh_%C4%90%C3%A1_%C4%90%C4%A9a.jpg/1280px-G%C3%A0nh_%C4%90%C3%A1_%C4%90%C4%A9a.jpg" || true

# 4. Mũi Điện / Đại Lãnh
download_img "mui-dien.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Mui_Dien_Cape.png/1280px-Mui_Dien_Cape.png" || true

# 5. Tháp Nghinh Phong Tuy Hòa
download_img "thap-nghinh-phong.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/%C4%90%C6%B0%E1%BB%9Dng_ph%E1%BB%91_%E1%BB%9F_Tuy_H%C3%B2a_nh%C3%ACn_t%E1%BB%AB_th%C3%A1p_Nghinh_Phong.jpg/1280px-%C4%90%C6%B0%E1%BB%9Dng_ph%E1%BB%91_%E1%BB%9F_Tuy_H%C3%B2a_nh%C3%ACn_t%E1%BB%AB_th%C3%A1p_Nghinh_Phong.jpg" || true

# 6. Nhà thờ Mằng Lăng
download_img "mang-lang.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Nh%C3%A0_th%E1%BB%9D_M%E1%BA%B1ng_L%C4%83ng_-_Ph%C3%BA_Y%C3%AAn.jpg/1280px-Nh%C3%A0_th%E1%BB%9D_M%E1%BA%B1ng_L%C4%83ng_-_Ph%C3%BA_Y%C3%AAn.jpg" || true

# 7. Đầm Ô Loan
download_img "dam-o-loan.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/%C4%90%E1%BA%A7m_%C3%94_Loan%2C_An_Hi%E1%BB%87p%2C_Tuy_An%2C_Ph%C3%BA_Y%C3%AAn.jpeg/1280px-%C4%90%E1%BA%A7m_%C3%94_Loan%2C_An_Hi%E1%BB%87p%2C_Tuy_An%2C_Ph%C3%BA_Y%C3%AAn.jpeg" || true

# 8. Bãi Xép Phú Yên
download_img "bai-xep.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/B%C3%A3i_X%C3%A9p_1.jpg/1280px-B%C3%A3i_X%C3%A9p_1.jpg" || true

# 9. Cầu Thị Nại Quy Nhơn
download_img "cau-thi-nai.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/C%E1%BA%A7u_Th%E1%BB%8B_N%E1%BA%A1i%2C_Quy_Nh%C6%A1n.JPG/1280px-C%E1%BA%A7u_Th%E1%BB%8B_N%E1%BA%A1i%2C_Quy_Nh%C6%A1n.JPG" || true

# 10. Vịnh Xuân Đài & Đèo Cù Mông / QL1D
download_img "vinh-xuan-dai.jpg" "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Xuan_Dai_Bay%2C_Phu_Yen%2C_Vietnam.JPG/1280px-Xuan_Dai_Bay%2C_Phu_Yen%2C_Vietnam.JPG" || true

echo "--- DOWNLOAD SUMMARY ---"
ls -lh "$DIR"

