﻿<?xml version="1.0" encoding="utf-8"?>
<!--
  For more information on how to configure your ASP.NET application, please visit
  https://go.microsoft.com/fwlink/?LinkId=169433
  -->
<configuration>
  <connectionStrings>
    <add name="ConnectDBString" connectionString="server=184.168.194.70;Initial Catalog=SiddhiTours;User ID=SiddhiTours;password=Siddhi@2018;pooling=true;Max Pool Size=200;MultipleActiveResultSets=True" providerName="System.Data.SqlClient" />
  </connectionStrings>
  <appSettings>
    <add key="filePath" value="/Images/" />
  </appSettings>
  <system.web>
    <compilation debug="true" targetFramework="4.6.1" defaultLanguage="c#">
      <assemblies>
        <add assembly="System.IO.Compression, Version=4.1.2.0, Culture=neutral, PublicKeyToken=B77A5C561934E089" />
        <add assembly="System.IO.Compression, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089" />
        <add assembly="System.IO.Compression.FileSystem, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089" />
        <add assembly="System.ComponentModel.Composition, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089" />
        <add assembly="System.Numerics, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B77A5C561934E089" />
        <!--<add assembly="System.Net.Http, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A" />-->
      </assemblies>
    </compilation>
    <httpRuntime targetFramework="4.6.1" maxRequestLength="1048576" />
    <customErrors mode="Off" />
    <trust level="Full" />
  </system.web>
  <!--system.codedom>
    <compilers>
      <compiler language="c#;cs;csharp" extension=".cs" type="Microsoft.CodeDom.Providers.DotNetCompilerPlatform.CSharpCodeProvider, Microsoft.CodeDom.Providers.DotNetCompilerPlatform, Version=1.0.7.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" warningLevel="4" compilerOptions="/langversion:default /nowarn:1659;1699;1701" />
      <compiler language="vb;vbs;visualbasic;vbscript" extension=".vb" type="Microsoft.CodeDom.Providers.DotNetCompilerPlatform.VBCodeProvider, Microsoft.CodeDom.Providers.DotNetCompilerPlatform, Version=1.0.7.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" warningLevel="4" compilerOptions="/langversion:default /nowarn:41008 /define:_MYTYPE=\&quot;Web\&quot; /optionInfer+" />
    </compilers>
  </system.codedom--!>
  <runtime>
    <assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
      <dependentAssembly>
        <assemblyIdentity name="System.IO.FileSystem" publicKeyToken="b03f5f7f11d50a3a" culture="neutral" />
        <bindingRedirect oldVersion="0.0.0.0-4.0.2.0" newVersion="4.0.2.0" />
      </dependentAssembly>
      <dependentAssembly>
        <assemblyIdentity name="System.Security.Cryptography.X509Certificates" publicKeyToken="b03f5f7f11d50a3a" culture="neutral" />
        <bindingRedirect oldVersion="0.0.0.0-4.1.1.0" newVersion="4.1.1.0" />
      </dependentAssembly>
      <dependentAssembly>
        <assemblyIdentity name="System.IO.FileSystem.Primitives" publicKeyToken="b03f5f7f11d50a3a" culture="neutral" />
        <bindingRedirect oldVersion="0.0.0.0-4.0.2.0" newVersion="4.0.2.0" />
      </dependentAssembly>
      <dependentAssembly>
        <assemblyIdentity name="System.Diagnostics.DiagnosticSource" publicKeyToken="cc7b13ffcd2ddd51" culture="neutral" />
        <bindingRedirect oldVersion="0.0.0.0-4.0.1.0" newVersion="4.0.1.0" />
      </dependentAssembly>
    </assemblyBinding>
  </runtime>
</configuration>