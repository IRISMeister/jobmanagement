# Misc

実験用のプロダクション。Misc.NewProduction。

```
$ docker compose exec job iris session iris -UJOB
JOB>d ^DirectFlow
経過時間: 30.019987,秒
```
# flowについて

[Misc.BP.Flow.bpl](http://localhost:9203/csp/job/EnsPortal.BPLEditor.zen?BP=Misc.BP.Flow.bpl)

```
JOB>d ^DirectFlow
経過時間: 30.019987,秒
```

\<flow\>は、その配下のsequenceを順序不定で実行する。並列(同時)実行はしない。可能な場合、sequenceを切り替えながら実行する。

```
The <flow> element specifies that each of the elements it contains are executed in a non-determinate order. A <flow> element contains one or more <sequence> elements, each of which is referred to as a thread.
```
flowは複数のsequenceを保持できる。

```
If possible, the execution of threads is interlaced. For example, if the execution of one thread is suspended (say it is waiting for a response from a asynchronous call), then execution of one of the other threads proceeds (if possible).
```
Threadの実行が"suspended"された場合、別のThreadが実行される。

>非同期コール以外のsuspendedされる契機は?

```
Note that, strictly speaking, the threads within a <flow> element do not execute at the same time: this is because only one thread is given access to the business process execution context at a time, to preserve proper concurrency and data consistency.
```
各threadが同時実行されることはない。=> 並列実行ではない。

```
The <flow> element waits for all of its threads to complete before it allows execution to continue. After both threads in the previous example are completed, execution continues and <call> element E is executed.
```
全sequenceの完了の待ち合わせをしてくれるので、「複数の状態を待ち合わせる」のに便利かもしれない。

本例が完了に30秒かかるのは、Call1,Call2はOPで平行で実行されているが、その完了に10秒、Seq#1, Seq#2にそれぞれcodeブロックで10秒かかるが、それらはBP上での処理であり、並列実行されないので、各々で+10秒される。
Seq#3は、OP上で計20秒かかるが、BPでは時間がかかる要素(本例ではcode)がない。  
結果、全体の完了には30秒かかる。