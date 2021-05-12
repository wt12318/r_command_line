# r_command_line
scripts for command line use

## 批量替换代码中的字符

使用方法：

```shell
./qgsub.R -h
Usage: ./qgsub.R [options]


Options:
        -t TEMPLATE, --template=TEMPLATE
                File need to be changed

        -m MAPPING, --mapping=MAPPING
                Mapping file, each column corresponds to the values to replace

        -r REPLACE, --replace=REPLACE
                Character that need to be replaced, if there are more than 1 word, words should been splited by space

        -p PREFIX, --prefix=PREFIX
                Prefix of output files

        -s SUFFIX, --suffix=SUFFIX
                Suffix of output files

        -d DIR, --dir=DIR
                output dir

        -h, --help
                Show this help message and exit
```

比如，现在有一个需要替换的PBS文件`test_com.pbs`(需要将`<file1>`和`<file2>`替换成多个文件名)，要替换的文件放在`-t`参数后面：

```shell
#PBS -N run_NeoPredPipe
#PBS -l nodes=1:ppn=2
#PBS -l walltime=480:00:00
#PBS -S /bin/bash
#PBS -q pub_fast
#PBS -j oe

NeoPredPipe.py -I <file1> -H hla_typing.txt -O <file2>
```

将需要替换的字符放在`-r`参数后面,多个字符用空格分割；将用来替代的内容放在`-m`参数后，每列代表相应的替换内容(比如第一列表示`-r`中要替换的第一个字符所要替代的内容，以此类推，列之间以空格分割)；输出文件的前缀用`-p`表示,后缀用`-s`表示；输出文件路径放在`-d`后：

```shell
##map文件
f1 o1
f2 o2
f3 o3
```

```shell
qgsub.R -t test_com.pbs  -m map -r "<file1> <file2>" -p test_ -s pbs -d out/

ls out
#test_f1.pbs  test_f2.pbs  test_f3.pbs
```







