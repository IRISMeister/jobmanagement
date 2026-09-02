Class Misc.NewProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Misc.NewProduction" TestingEnabled="false" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="Main" Category="" ClassName="Misc.BP.Main" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Main2" Category="" ClassName="Misc.BP.Main2" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Sub" Category="" ClassName="Misc.BP.Sub" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Direct1" Category="" ClassName="Misc.BS.Direct1" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Direct2" Category="" ClassName="Misc.BS.Direct2" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Direct3" Category="" ClassName="Misc.BS.Direct3" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DirectFlow" Category="" ClassName="Misc.BS.DirectFlow" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Wait10Secs" Category="" ClassName="Misc.OP.Wait10Secs" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Wait10000Secs" Category="" ClassName="Misc.OP.Wait10000Secs" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="CallDefer" Category="" ClassName="Misc.BP.CallDefer" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Flow" Category="" ClassName="Misc.BP.Flow" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Defer" Category="" ClassName="Misc.OP.Defer" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DeferReq" Category="" ClassName="Misc.BS.DeferReq" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DeferRes" Category="" ClassName="Misc.BS.DeferRes" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="CallBP" Category="" ClassName="Misc.BP.CallBP" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="cBP" Category="" ClassName="Misc.BP.cBP" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="DirectComponent" Category="" ClassName="Misc.BS.DirectComponent" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="WaitSecs" Category="" ClassName="Misc.OP.WaitSecs" PoolSize="2" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="FlowMany" Category="" ClassName="Misc.BP.FlowMany" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DirectFlowMany" Category="" ClassName="Misc.BS.DirectFlowMany" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="NoOp" Category="" ClassName="Misc.OP.NoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="Pool=1での実行を想定。FIFOは保たれるが、並列実行はされない。何か一瞬で完了するオペレーションが実行されることを想定。" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp01" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp02" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp03" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp04" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp05" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp06" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp07" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp08" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp09" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp10" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="cBPNoOp11" Category="" ClassName="Misc.BP.cBPNoOp" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
