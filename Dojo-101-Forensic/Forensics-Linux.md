# Forensics Linux

## Dump de la RAM

* [LiME (archived)](https://github.com/504ensicsLabs/LiME)

## Montages de disques / Volumes

### Montage read only

```bash
mount  -o loop,ro,noexec img.dd  /mnt
```

> [!TIP]
> ne remplace pas duplicateur avec un bloqueur Hardware en écriture.

### dc3dd

fork de dd qui tolère les clusters défectueux

```bash
dc3dd if=/dev/sdb hof=/mnt/extdrive/WKS042.dd log=/mnt/extdrive/dd_WKS042.log
```

Pour le montage il faut determiner le secteur du début de partition (NTFS)

```bash
mmls WKS042.dd
```

---

*Dojo-101 — [🏠 Sommaire principal](../README.md) • [📂 Sommaire du thème](./README.md) • [💖 Soutenir ce projet sur GitHub Sponsors](https://github.com/sponsors/Aif4thah/)*
