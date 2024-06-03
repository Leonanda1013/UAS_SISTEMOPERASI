#!/bin/bash

show_menu(){
    echo "Menu:"
    echo "1. Buat file"
    echo "2. Keluar"
    echo "3. Lihat File"
    echo "4. Hapus File/Folder"
    echo "5. Copy File"
    echo "6. Move File"
    echo "7. Kompres File"
    echo "8. Ekstrak File"
    echo "9. Kompres Folder"
    echo "10. Ekstrak Folder"
    echo "11. Kalkulator"
}

create_file(){
    touch "$1"
    echo "File $1 berhasil dibuat"
}

list_files(){
    ls -l
}

delete_file_or_folder(){
    read -p "Masukkan nama file/folder yang ingin dihapus: " file_or_folder
    if [ -d "$file_or_folder" ]; then
        rm -r "$file_or_folder"
    else
        rm -i "$file_or_folder"
    fi
    echo "$file_or_folder berhasil dihapus"
}

copy_file(){
    read -p "Masukkan nama file yang ingin disalin: " src
    read -p "Masukkan tujuan salinan: " dest
    cp "$src" "$dest"
    echo "File $src berhasil disalin ke $dest"
}

move_file(){
    read -p "Masukkan nama file yang ingin dipindahkan: " src
    read -p "Masukkan tujuan pemindahan: " dest
    mv "$src" "$dest"
    echo "File $src berhasil dipindahkan ke $dest"
}

compress_file(){
    read -p "Masukkan nama file yang ingin dikompres: " file
    gzip -c "$file" > "$file.gz"
    echo "File $file berhasil dikompres menjadi $file.gz"
}

extract_file(){
    read -p "Masukkan nama file terkompres (dengan ekstensi .gz) yang ingin diekstrak: " file
    gunzip "$file"
    echo "File $file berhasil diekstrak"
}

compress_folder(){
    read -p "Masukkan nama folder yang ingin dikompres: " folder
    tar -czf "$folder.tar.gz" "$folder"
    echo "Folder $folder berhasil dikompres menjadi $folder.tar.gz"
}

extract_folder(){
    read -p "Masukkan nama folder terkompres (dengan ekstensi .tar.gz) yang ingin diekstrak: " folder
    tar -xf "$folder"
    echo "Folder $folder berhasil diekstrak"
}

calculator(){
    echo "Kalkulator Sederhana"
    read -p "Masukkan angka pertama: " num1
    read -p "Masukkan operasi (+, -, *, /): " op
    read -p "Masukkan angka kedua: " num2
    
    case $op in
        +) result=$(echo "$num1 + $num2" | bc) ;;
        -) result=$(echo "$num1 - $num2" | bc) ;;
        \*) result=$(echo "$num1 * $num2" | bc) ;;
        /) result=$(echo "scale=2; $num1 / $num2" | bc) ;;
        *) echo "Operasi tidak valid." ;;
    esac
    
    echo "Hasil: $result"
}

while true; do
    show_menu
    read -p "Masukkan pilihan: " choice
    case $choice in
        1)
            read -p "Masukkan nama file: " nama_file
            create_file "$nama_file"
            ;;
        2)
            echo "Keluar dari program."
            exit
            ;;
        3)
            list_files
            ;;
        4)
            delete_file_or_folder
            ;;
        5)
            copy_file
            ;;
        6)
            move_file
            ;;
        7)
            compress_file
            ;;
        8)
            extract_file
            ;;
        9)
            compress_folder
            ;;
        10)
            extract_folder
            ;;
        11)
            calculator
            ;;
        *)
            echo "Pilihan tidak valid."
            ;;
    esac
done
