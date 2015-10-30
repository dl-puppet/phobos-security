
# blkid donne un apperçu des partitions + UUID existantes
# mount /dev/sda /mnt/test   ou   mount UUID="xxxxxxxx" /mnt/test
# lsof : enumere tous les fichiers ouverts et les processus qui a acces dans le repertoire indiqué
# fdisk/gdisk : partition selon le schéma MBR (MBR supplanté par GTP (gdisk) (GUID Partion Table))   (package gdisk)
  # exemple gdisk:
    # spécifier le disk:  gdisk /dev/sda
    # demande nouvelle partition: n
    # etc...

# partprobe : initiez la relecture de la table de partition par le noyau.  ex: partprobe /dev/sda

# mkfs : formatage des partition/ creation fs (ext4/xfs use by anaconda prog install redhat)
# 
