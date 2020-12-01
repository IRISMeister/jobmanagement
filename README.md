# jobmanagement

## How to install 
```bash
$ git clone https://github.com/IRISMeister/jobmanagement.git
$ cd jobmanagement
$ docker-compose build
```
## How to Run 
```bash
$ docker-compose up -d
```
Management portal will be avaliable at   
http://irishost:9203/csp/job/EnsPortal.ProductionConfig.zen?$NAMESPACE=JOB&PRODUCTION=Task.Production1  
This is Job Production. Interoperability is enabled.    
http://irishost:9204/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=TASK  
This is one of the two target servers where task will be executed.  
http://irishost:9205/csp/sys/%25CSP.Portal.Home.zen?$NAMESPACE=TASK  
This is another target server.  
Use _SYSTEM/SYS to log in.

## How to stop/down
```bash
$ docker-compose stop
or
$ docker-compose down
```
## about
[Task manager](http://irishost:9203/csp/sys/op/%25CSP.UI.Portal.TaskInfo.zen?$ID1=1000) kicks a [task](job/src/SysTask/Job1.cls) which calls [Initiator](job/src/Task/Service/Initiator.cls) BS every 5 minutes. You will see messages which calls "Job1" BP which in turn calls Target1 BO and Target2 BO.  
Target1 BO makes reset calls to task server #1 and performs [MyTask.NewClass1](task/src/MyTask/NewClass1.cls) and [MyTask.NewClass2](task/src/MyTask/NewClass2.cls) there.  
```
$ docker-compose exec task iris session iris -U task
TASK>zw ^MyTask
^MyTask=4
^MyTask(1)=$lb("10/29/2020 18:10:00","MyTask.NewClass1","1","abc",5,"","","")
^MyTask(2)=$lb("10/29/2020 18:10:05","MyTask.NewClass2",1,"abc",5,"","","")
^MyTask(3)=$lb("10/29/2020 18:15:00","MyTask.NewClass1","18","abc",5,"","","")
^MyTask(4)=$lb("10/29/2020 18:15:05","MyTask.NewClass2",18,"abc",5,"","","")
TASK>h
```
Target2 BO makes reset call to task server #2 and performs MyTask.NewClass3.
```
$ docker-compose exec task2 iris session iris -U task
TASK>zw ^MyTask
^MyTask=2
^MyTask(1)=$lb("10/29/2020 18:10:05","MyTask.NewClass3",1,"abc",5,"","","")
^MyTask(2)=$lb("10/29/2020 18:15:05","MyTask.NewClass3",18,"abc",5,"","","")
TASK>h
```

## How to edit with VSCode
Select "Open Workspace..." and open jobmanagement.code-workspace file.  
It uses workspace to handle two IRIS namespaces and connections.
main 
 docker-compose file. 
job
 Docker related files for namespace JOB
task
 Docker related files for namespace TASK
