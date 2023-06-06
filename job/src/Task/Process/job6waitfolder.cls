/// Wait Folders
Class Task.Process.job6waitfolder Extends Ens.BusinessProcessBPL [ ClassType = persistent, DependsOn = Task.Context.Custom, ProcedureBlock ]
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Task.Request.CallJob' response='Task.Response.CallJob' contextsuperclass='Task.Context.Custom' height='2000' width='2000' >
<sequence xend='200' yend='1300' >
<scope xpos='200' ypos='250' xend='200' yend='1100' >
<call name='call1' target='cWaitFolder' async='1' xpos='200' ypos='350' >
<annotation><![CDATA[folder1の待ちを登録]]></annotation>
<request type='Task.Request.WaitFolder' >
<assign property="callrequest.FolderName" value="&quot;/home/sftp_user1/incoming/folder1/&quot;" action="set" />
</request>
<response type='Task.Response.WaitFolder' />
</call>
<call name='call2' target='cWaitFolder' async='1' xpos='200' ypos='450' >
<annotation><![CDATA[folder2の待ちを登録]]></annotation>
<request type='Task.Request.WaitFolder' >
<assign property="callrequest.FolderName" value="&quot;/home/sftp_user2/incoming/folder2/&quot;" action="set" />
</request>
<response type='Task.Response.WaitFolder' />
</call>
<sync calls='call1,call2' type='all' xpos='200' ypos='550' />
<foreach property='syncresponses' key='context.iterator' xpos='200' ypos='650' xend='200' yend='600' >
<annotation><![CDATA[エラーの有無確認]]></annotation>
<if condition='syncresponses.GetAt(context.iterator).TaskStatus="OK"' xpos='200' ypos='250' xend='200' yend='500' >
<true>
<assign property="context.Files" value="syncresponses.GetAt(context.iterator).Files" action="append" xpos='470' ypos='400' />
</true>
<false>
<throw fault='"JobFault:"_syncresponses.GetAt(context.iterator).TaskErrorMessage' xpos='200' ypos='400' />
</false>
</if>
</foreach>
<code xpos='200' ypos='750' >
<annotation><![CDATA[対象ファイル群を保持するネストしたリスト構造をフラットな構造に変換]]></annotation>
<![CDATA[ Do context.ProcessFiles()]]>
</code>
<call name='call3' target='Archive' async='0' xpos='200' ypos='850' >
<annotation><![CDATA[ファイル群をzipして外部に送信する。ファイル群は削除される。]]></annotation>
<request type='Task.Request.ArchiveFiles' >
<assign property="callrequest.Files" value="context.TargetFiles" action="set" />
</request>
<response type='Ens.Response' />
</call>
<faulthandlers>
<catchall xpos='200' ypos='950' xend='200' yend='550' >
<trace value='"%LastError "_$System.Status.GetErrorCodes(..%Context.%LastError)_" : "_$System.Status.GetOneStatusText(..%Context.%LastError)' xpos='200' ypos='250' />
<assign property="response.JobStatus" value="&quot;NG&quot;" action="set" xpos='200' ypos='350' />
<assign property="response.JobErrorMessage" value="$System.Status.GetErrorCodes(..%Context.%LastError)_&quot;:&quot;_$System.Status.GetOneStatusText(..%Context.%LastError)" action="set" xpos='200' ypos='450' />
</catchall>
</faulthandlers>
</scope>
<assign property="response.EndTime" value="$ZDATETIME($H,3)" action="set" xpos='200' ypos='1200' />
</sequence>
</process>
}

}
