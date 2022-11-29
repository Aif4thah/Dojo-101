# archive zip tar

## Compress file
```shell
zip compressed.zip file_name.txt
```
## Compress Folder

```shell
zip -r compressed.zip folder_name/
```

## Uncompress zipped file to current directory

```shell
unzip compressed.zip
```

## Uncompress zipped to current directory to specific location

```shell
unzip compressed.zip -d ~/Documents
```

## Compress a file / folder

```shell
tar zcvf compressed.tar.gz folder_name
```

## Uncompress a tar file

```shell
tar zxvf compressed.tar.gz
```

## tout détarer:

```shell
for i in *.tar.gz; do tar -xzvf $i; done
```
