Class DeadLock.NewProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="DeadLock.NewProduction" TestingEnabled="false" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="Main" Category="" ClassName="DeadLock.BP.Main" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Sub" Category="" ClassName="DeadLock.BP.Sub" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Direct" Category="" ClassName="DeadLock.BS.Direct" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Direct2" Category="" ClassName="DeadLock.BS.Direct2" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Main2" Category="" ClassName="DeadLock.BP.Main2" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="Direct3" Category="" ClassName="DeadLock.BS.Direct3" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Wait" Category="" ClassName="DeadLock.OP.Wait" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Defer" Category="" ClassName="DeadLock.BP.Defer" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="OPDefer" Category="" ClassName="DeadLock.OP.Defer" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DeferReq" Category="" ClassName="DeadLock.BS.DeferReq" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DeferRes" Category="" ClassName="DeadLock.BS.DeferRes" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
