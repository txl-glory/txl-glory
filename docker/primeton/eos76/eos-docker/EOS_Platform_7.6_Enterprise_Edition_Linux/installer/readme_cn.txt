               EOS Platform 7.6 概要说明

欢迎使用EOS Platform 7.6 产品并提出宝贵意见，您可参见联系方式与我们联系

========================================
本文档包含以下内容：

   1. 关于普元软件

   2. 产品简介

   3. 产品关键特性
	
   4. 产品新功能特性

   5. 联系方式
========================================
1.  关于普元软件
	普元（Primeton）是中国领先的基础软件产品与解决方案提供商，长期致力于与客户及合作伙伴紧密合作，采用平台化方式建设IT基础设施，支撑中国企业的业务创新与发展。普元系国家规划布局内重点软件企业，并是国际标准组织OASIS核心成员、SOA国际标准SCA/SDO的主要参与制定者、中国SOA标准工作组副组长单位。

	普元专注于基础软件平台领域，凭借掌握的服务构件技术、可视化技术、业务流程管理、并行计算、内存计算、企业移动计算、数据治理等核心技术，开发出拥有自主知识产权的系列平台软件产品，包括SOA应用交付平台、SOA业务集成平台、IT运维平台、大数据平台、云计算平台等。普元拥有多项国家软件发明专利，同时是中国少数通过国际软件成熟度整合模式（CMMI）5级认证的软件厂商之一。
	
	在中国市场，普元产品已经在金融、电信、电力、军工、能源、政府、制造、物流等多个行业的数千关键应用上得到验证，拥有中国工商银行、中国建设银行、中国交通银行、国家开发银行、中国银联、宁波银行、上海银行、北京银行、中国移动、中国电信、中国联通、国家电网、神华集团、航天科工、中航工业、文化部、首都之窗、中华煤气、阿里云、德邦物流等超过300家以上的大中型用户。在海外市场，通过与华为公司合作，普元产品已销往加拿大、巴西、日本、科威特、南非、也门、印度、荷兰、泰国等40余个国家。
	
	普元重视构建合作共赢的商业生态，与华为、亚信联创、太极股份、远光软件、亿阳信通、高伟达、南天、中科软等200余家大中型软件商深入合作，公司在北京、上海、广州、深圳、成都、西安、武汉等地设有分支机构，为各行业用户及合作伙伴提供高品质的技术服务，全面保障产品成功使用。
	
	普元先后成功承担了多项国家、省部级重点科研课题及产业化项目，如国家发改委软件产业化专项、国家发改委云计算专项、上海科教兴市重大科技攻关项目等，普元系列产品多次荣获上海市科技进步奖、上海市优秀软件产品等重要奖项。此外，普元是国家博士后科研工作站、国家高技术产业化示范工程单位、国家云计算服务创新发展试点示范单位。
	
	普元由多位已取得卓越成就的企业家和科学家携手创立，汇聚了一流的计算机技术专家、管理精英和各类专业人才。公司总部位于上海张江高科技园区。

========================================
2.  产品简介：
	该产品基于JavaEE、Eclipse等开放的技术和平台，通过配置化、组件化、图形化、一体化的平台产品为客户提供完整的覆盖应用全生命周期的支撑，可以真正意义上帮助企业客户和各类机构实现其统一SOA架构的发展策略，并达到低成本、高质量、灵活、易管控的构造SOA应用和服务的目标。

	支持单表、主从表、视图、实体、查询实体等多种类型的元数据
	支持向导方式创建多种企业软件系统业务场景
	支持图形化、业务化配置方式实现表单建模
	标准化的组件扩展，通过功能强大的技术平台快速扩展业务组件
	提供了强大的后台数据处理引擎，可实现数据自动入库，无需代码
	支持图形化、业务化配置方式实现流程建模
	提供功能丰富的流程监控跟踪功能和强大的流程统计分析功能
	采用了先进的SOA体系架构和标准规范，统一地解决了业务、技术与管理的应用架构
	组件化、业务化、图形化、可配置
	丰富的业务及技术组件
	本版本套件内置了业界领先的SOA基础应用平台产品 EOS 和 SOA业务流程平台产品 BPS ，以下就本套件包含的两个构成产品EOS  和BPS 逐一进行介绍：

2.1 EOS 简介
	EOS作为全球领先的SOA应用平台，秉承一贯的产品特色与优势，把构件技术、可视化技术、图形化技术与SCA、SDO等SOA技术标准完美结合起来，为客户提供了从设计开发和调试部署，到运行维护和管控治理的覆盖SOA应用全生命周期的平台支撑。
	
	该产品组件主要包括Server（运行环境）、Studio（集成开发环境）、Governor（治理工具）、Component Library（构件库）、EOS RichWeb（富页面）、五个部分，并同时依托goCom社区提供了Application Framework的开源实现供客户自主定制。

2.1.1 Server (运行环境)
	Server是支撑SOA应用和服务的运行环境， Server 由SCA（Service Component Architecture） 容器、构件运行环境、页面流引擎、逻辑流引擎、系统服务、基础服务等核心模块组成。Server是一个面向SOA的基础设施，实现了SOA的核心编程模型SCA 1.0、SDO 2.1的标准规范。

	Server保障了SOA应用或服务稳定、安全、可靠、高效、可扩展地运行。
	Server运行在标准的JavaEE应用服务器之上，支持主流的应用服务器(如：WebSphere、 WebLogic、 JBoss、 Tomcat等)和主流的数据库(Oracle、DB2、 MS SQL Server等) 。

2.1.2 Studio (集成开发环境)
	Studio是集面向构件应用的设计、开发、组装、调试、维护、部署、管理和发布于一体的集成开发环境，提供对SOA应用和服务全生命周期的开发、维护和管理。在Studio中，以项目的形式组织了EOS 应用开发的资源，提供相应的向导、视图和编辑器等工具供开发人员在开发过程中可视化地开发各种构件，并提供了强大的调试及团队开发功能。

2.1.3 Governor（治理工具）
	Governor 主要功能是以图形化的方式实现对EOS系统运行时刻进行监控，以利于系统开发人员及运行管理人员进行系统调试与系统诊断。通过实时在线监控和管理工具，可以实现对应用系统各个层次进行监控和管理。用户只需通过Web界面即可实时监控应用系统的各项运行参数，快速诊断和修正系统运行时的错误及异常，用更少的维护成本确保系统正常发挥作用。

2.1.4 Component Library (基础 构件库)
	Component Library是为了支撑快速开发、部署应用系统而提供的，具有高度复用能力的一组预制构件的集合。利用EOS构件库中的构件可以快速搭建应用系统，提高软件可复用度和开发效率；同时通过对构件的管理可以建立一套针对构件的生产、改进、管理、沉淀和发展的完整软件管理机制，使得企业在组织级的软件知识沉淀可以通过构件库的形式得以实现和发展。

2.1.5 RichWeb（富页面）
	RichWeb 提供了丰富的页面模板、页面控件以及页面向导，将开发人员从繁琐、复杂、费时的页面开发中解脱出来。通过页面模板自定义，系统分析设计人员可以针对不同项目需要定制统一的页面风格。开发人员可通过拖拉页面控件的方式轻松实现页面开发。

2.1.6 SCE（在线开发环境：可选部署包）
	SCE支持单表、主从表、视图、实体、查询实体等多种类型的元数据，支持向导方式创建多种企业软件系统业务场景，支持图形化、业务化配置方式实现表单建模标准化的组件扩展，通过功能强大的技术平台快速扩展业务组件提供了强大的后台数据处理引擎，可实现数据自动入库，无需代码，支持图形化、业务化配置方式实现流程建模，提供功能丰富的流程监控跟踪功能和强大的流程统计分析功能。

2.2 BPS 简介
	该产品组件是业界第一个完全基于业务化思想实现的SOA业务流程平台产品，负责对业务流程整个生命周期的管理，包括业务流程的设计建模、测试与调试、部署、运行、监控、管理。BPS是遵从WFMC参考模型而又具备中国特色相关特性的流程平台产品。它溶入了国内电子政务与电信等行业的特征要求，在符合WFMC规范的同时，又提供了灵活的工作任务分派策略、业务流程版本管理策略、丰富的流程模式、灵活的组织模型等特性，使得它能够从容应对复杂的中国特色流程模式和人工流程的处理。BPS采取了多种方式以保证流程引擎的高效稳定运行，满足大型流程应用建设需求，比如良好的事件驱动式系统架构、优化的工作流数据库、高效稳定并且有巨量吞能力的短流程机制、历史数据与运行数据分离、集群高速缓存等。BPS具有卓越的面向业务的流程配置能力，支持业务部门的流程管理人员基于Web的方式进行流程的业务化配置与调整，从而敏捷响应业务流程的变更。
	
	BPS由以下十一大部分产品组件组成：Process Server（流程引擎）、Rule Engine(规则引擎)、API & Component Library（API和构件库）、Studio（流程设计建模工具）、Governor（引擎治理工具）、Admin & Monitor（流程管理监控台）、Work Client（流程客户端）、Rule Composer(业务规则定制)、Web Service Integrator（Web服务集成器）、Business Process Composer（业务流程定制）、Process Statistic（流程统计分析）。

2.2.1   Process Server（流程引擎）
	Process Server（流程引擎）是BPS的心脏，它保证大数据量并发场景下的流程操作的顺利执行。它共有三个职责：流程调度、任务调度和应用调度。BPS Process Server支持包含自由流、短流程在内的多种复杂的流程模式，能满足中国特色的业务灵活需求；同时，它还支持复杂的代理代办模型，对人工任务的灵活性存在很大的优势；同时负责和内部与外部的各种应用以同步和异步方式进行交互，保证引擎处理过程中的事务完整性，促使互联网时代大量业务交互能够顺利进行。

2.2.2   Rule Engine（规则引擎）
	Rule Engine（规则引擎）是一个高性能的业务规则运行环境，它能从业务变量以及系统环境数据中获取必要的数据作为决策数据源，通过复杂计算得出条件判断结果或者参与者集合，然后把结果传递给流程引擎使用。通过把业务规则引擎和流程引擎的配合使用，可以大大提高业务配置化能力，快速支持业务流程和业务策略的变更。

2.2.3   API & Component Library（API和构件库）
	API & Component Library（API和构件库）提供众多的流程API与EOS服务构件，为流程业务开发提供了极大的便捷性。在实际的应用开发过程中，Java开发模式中一般是通过API调用流程引擎所提供的服务，EOS平台开发模式中一般是通过调用EOS服务构件中的服务来使用流程引擎所提供的服务。BPS API和构件库是工作流引擎的访问接口，是对引擎功能的完备封装。BPS API和构件库包括：流程定义管理接口和服务、实例管理接口和服务、客户端接口和服务、代理代办接口和服务、特殊功能接口和服务以及页面标签库。

2.2.4   Studio Plug-ins（流程设计建模工具包）
	Studio Plug-ins （流程设计建模工具包）是基于Eclipse插件体系结构实现的可视化流程设计器，它既可以与用户基于Eclipse的Java集成开发环境融合，又能与EOS Studio 集成开发环境无缝集成，提供一体化的流畅的开发体验。

2.2.5   Governor（引擎治理工具）
	Governor（引擎治理工具）是集成BPS提供的系统管理工具，系统管理员可以通过它对BPS流程引擎进行配置和管理。

2.2.6   Process Composer（业务流程定制）
	Process Composer（BPS业务流程定制）是在BPS流程引擎之上实现的基于Web的业务化流程定制工具，它支持业务部门的流程管理人员基于Web的方式进行流程的业务化配置与调整，为业务人员提供完全的业务域支撑能力，敏捷响应业务流程的变更。

2.2.7   Rule Composer（业务规则定制）
	Rule Composer（BPS业务规则定制）是在BPS流程引擎和BPS规则引擎之上实现的基于Web的业务化规则定制工具，通过该组件，业务管理人员可以在系统维护期间维护业务规则，使业务策略的变更及时体现到IT系统当中。业务规则定制过程中可以引用业务变量、流程上下文数据、活动上下文数据等，以"类自然语言"的方式进行灵活的配置，并可以进行各种复杂的运算。

2.2.8   Admin & Monitor（流程管理监控台）
	Admin & Monitor（流程管理监控台）是业务流程管控人员的工作流操作平台。通过它业务流程管控人员不但可以对流程实例实施挂起、恢复、回退等操作，还可以进行代理代办交接等管理动作，甚至可以查询业务审计日志，对业务操作人员的流程动作进行监控。

2.2.9   Work Client（流程客户端）
	Work Client（流程客户端）是一个客户端的典型案例，它为流程的开发、调试和验证提供极大的便捷性。通过流程客户端，业务人员和开发人员不但可以执行启动流程、查看任务、完成任务等基本操作，还可以进行包括代理、代办、领取等复杂操作。流程客户端主要用来进行流程的模拟调试，验证流程的可行性和正确性。在业务运行阶段，应用一般需要构造满足自己特殊需要的客户端。

2.2.10 Web Service Integrator（Web服务集成器）
	Web Service Integrator（Web服务集成器）通过图形化拖拉拽的方式方便的实现Web Service的引入和调用，无需任何编码就可以实现服务调用、异常处理、集成调试等服务编制与集成相关工作，提供与其它系统的互联能力。

2.2.11 Process Statistic（流程统计分析）
	Process Statistic（流程统计分析）是Primeton BPSTM的可选组件。该组件是业务流程高级管理人员的流程统计和分析平台，通过它可以收集分析流程运转数据，提供对业务绩效指标的访问，以改进业务流程运作的速度和效率，可作为流程调整和优化的有力工具。

========================================
3. 产品关键特性
	Platform 产品套件由EOS 和BPS 两个产品构成，以下分别对套件中所包含的两个产品版本的关键特性进行说明：

3.1 EOS 产品关键特性

3.1.1 Server
	稳定、安全、可靠、高效、可扩展的企业级SOA 架构
	符合SCA 1.0 和SDO 2.1 等SOA 标准规范
	支持构件动态加载与远程加载
	支持集群部署
	能够整合多种开源框架
	构件包部署管理
	元数据读取

3.1.2 Studio
	高性能的开发工具: 对开发机器配置要求不高，512M～1G 内存情况下Studio 即可快速、稳定运行
	图形化的SOA 服务设计与服务装配: 支持Top-Down 模式的服务设计、装配与实现，也支持Bottom-Up 模式的先实现功能，再封装为服务的模式
	图形化的数据模型设计: 符合SDO 标准的实体定义，支持查询实体，支持非持久化实体，支持实体的关联关系
	图形化的构件组装: 图形化的构件组装只需要从构件库中拖拉构件，并对构件进行连线，配置相应的参数即可，显示符合规范并非常美观，操作方便。
	图形化的构件调试: 在开发构件时，可以直接对构件逻辑进行图形化的调试，并且调试期间支持热部署的能力，即时可以看到程序修改后的效果。支持远程调试。
	支持软件资产的沉淀、复用: 可以基于统一的技术平台方便实现对企业IT系统构件库的规划和实施；支持将业务构件导入到新的项目中复用；支持对已经积累的服务进行装配、调用；复用的业务构件越多，软件质量越有保证
	支持多种数据类型: 数据类型支持SDO、POJO、XML Schema、DOM
	支持多种服务的实现方式: 包括逻辑构件实现、Java 实现等多种方式供用户灵活选择。
	支持Web Service的开发：开发的Web Service完全遵循WSDL 1.1/SOAP1.1标准，支持Java实现类以及逻辑构件发布为Web Service；支持导入WSDL文件，并生成逻辑构件实现；逻辑流以及页面流中支持Web Service调用图元，支持生成Java调用Web Service客户端代码，支持attachment的接收与返回以及header的处理
	图形化的页面流开发: 支持变量的不同范围内的共享
	丰富的向导: 包括项目向导、对单表或多表进行增删改查等操作的功能向导、页面控件向导、页面向导等；常用功能自动生成代码，无需Coding
	丰富的Ajax 控件与普通页面控件,丰富页面控件属性向导
	支持团队开发
	支持设计文档自动生成，构件文档自动生成可以使得软件资产更方便管理
	支持构件的版本管理

3.1.3 Governor
	支持系统部署拓扑图查询
	支持集群部署
	支持构件动态部署、卸载、版本升级接割：一体化的打包工具，使得包括工作流在内的所有项目资源统一打包为部署包或者升级包，用户无需做任何手工部署操作。
	统一的构件部署环境，无论是普通应用还是工作流应用，部署过程都非常的简便
	构件在线管理监控: 可以实时对数据库链接与访问情况进行监控，对服务的调用情况进行监控，对页面的访问情况进行监控，对后台业务逻辑的运行情况进行监控
	所有的监控都是以业务构件为主线的
	参数统一配置：系统固有参数（如数据库连接参数、日志参数）以及业务构件的参数均可在统一的界面中进行配置
	支持构件历史运行情况统计: 提供了业务构件的调用频次、时间、访问量统计，让系统管理员可以有针对性的选择业务构件进行优化
	支持日志离线分析: 详细的系统与业务日志，有助于对系统的优化分析

3.1.4 Component Library
	丰富的基础构件，除了提供大量的最常用的基础运算构件库、基础业务构件库、资源访问构件外，还可以通过goCom 社区下载开源的应用框架构件库。
	并可支持第三方Jar 包直接封装为构件，无需做任何代码修改，即可通过工具自动封装为构件
	同样支持导入用户开发的业务构件库，在项目中积累的业务构件也可导入到构件库中，进行复用
	支持根据关键字查询所有构件库的功能

3.1.5 RichWeb
	提供了丰富的页面控件: 包括标准Html Tag、EOS Tag、EOS 页面控件、Ajax 控件、工作流控件，开发人员通过拖拽操作，以及通过属性向导来设置控件的属性，再配合少量简单的JSP 源码编辑即可完成页面开发过程
	提供了单表和主从表的维护向导，系统自动生成所有的代码，无需Coding
	大多数控件都提供了属性向导（尤其是功能强大的组合控件向导，如QueryForm,DataForm,ViewList,RecordView），开发人员将一个控件拖放到页面中时可以通过属性向导快速进行控件的设置。
	功能增强的表格、树控件
	常用控件的封装，更清晰的页面代码（日历，LookUp,RichText，业务字典）
	提供Ajax调用服务、逻辑流的API支持
	更方便的页面代码调试、错误定位
	JS代码采用压缩方式传输
	实现基本的js控件模型，能够在复杂控件中扩展新的js控件

3.1.6在线开发平台（须手工部署，默认不安装）
	支持定制开发平台
	支持在线开发数据集
	支持在线开发表单
	支持在线编辑脚本
	支持在线编辑脚本
	支持在线开发视图
	支持在线开发流程
	支持在线配置组织机构权限
	支持前后端连通
	支持团队开发
	支持门户集成

3.2 BPS产品关键特性

3.2.1 Process Server
	基于EOS Server 基础构架之上的轻量、稳定、安全、可靠、高效、可扩展的企业级业务流程引擎
	支持多种部署方式，支持远程独立部署
	支持业务化流程的运行期动态调整与部署
	支持集群部署
	流程定义及业务资源部署管理
	支持短流程和Web Service集成
	支持多种数据库的业务流程数据持久机制

3.2.2 Studio
	高性能的开发工具: 对开发机器配置要求不高，512M～1G 内存情况下Studio 即可快速、稳定运行
	与EOS Studio无缝集成，可以方便地使用EOS 提供的页面流、逻辑流、运算逻辑、EOS服务、Web Service 服务作为业务流程活动、触发事件等。
	图形化的业务流程建模: 支持T2B（Technology to Business）和B2T（Business to Technology）两种模式的业务流程、业务资源及相关服务的设计、建模及实现
	提供强大的与业务流程相关的组件库和API，可以方便地在EOS 或Java代码编程中使用。
	提供功能丰富的与业务流程相关的页面开发标签库（JSP Tag）
	无缝集成EOS 提供的Web Service开发功能，并可方便地集成和使用Web Service作为业务流程的自动活动
	提供业务流程初始建模偏好设置，减小流程开发工作量
	支持团队开发
	支持设计文档自动生成，构件文档自动生成可以使得软件资产更方便管理 

3.2.3 Governor
	与EOS Governor无缝集成，可以将流程与EOS 提供的ECD一同打包为ECD进行部署并管理
	提供流程引擎的系统参数（如：组织机构模型实现、登录权限实现、日志参数、短流程持久经配置等）的统一配置界面
	支持集群部署及管理
	支持日志离线分析: 详细的流程引擎相关的系统与业务审计日志，有助于进行系统的错误排查及优化分析

3.2.4 API & Component Library
	提供功能强大且贯穿流程全生命周期（流程定义、流程部署、流程版本管理、流程实例管理、任务管理、工作项管理、代理、代办、业务资源管理等）的业务流程API和基础构件。
	可以方便地在EOS 页面流、逻辑流中使用以上构件，方便流程应用功能开发
	可以方便地在Java代码开发过程中直接使用API进行流程应用功能开发
	与 EOS 基础构件库无缝集成

3.2.5 Process Composer
	提供了Based-Browser方式的基于Flex技术构建的业务流程定制组件，方便业务人员在运行期根据业务对企业业务流程快速建模，同时通过 BPS Work Client组件快速进行模拟测试
	支持BPS Studio 与BPS Process Composer建模的双向互通
	支持运行期调整
	提供了Based-Browser方式的业务资源定义和管理功能，可以方便地在运行期对业务变量、业务操作、人工任务、业务规则进行定制和调整
	提供Based-Browser方式的流程建模可视化编辑器
	提供业务流程建模的快捷菜单和属性页扩展机制
	提供权限控制机制，以区别不同人员对流程的管控粒度

3.2.6 Rule Composer
	提供了Based-Browser方式的基于Flex技术构建的业务规则编辑器
	支持BPS Studio 与BPS Rule Composer建模的双向互通
	支持分支规则和参与者规则两种规则
	支持运行期调整和动态编译
	规则中支持流程上下文数据

3.2.7 Admin & Monitor
	基于统一流程管理框架，可实现多引擎的同时管理和监控
	支持流程业务目录建模及流程按业务目录的分类分权限管理功能
	支持流程定义及版本管理
	支持流程实例管理及运行期干预（如：流程实例挂起、转派、恢复、重启等）
	支持流程实例的子流程钻取功能
	支持流程实例多条件查询功能
	支持流程实例的代办、代理、协办等特色特性的一站式管理
	支持流程实例审计
	支持流程定义及相关资源定义的导入、导出管理

3.2.8 Work Client
	产品提供的帮助用户快速进行业务流程运行期调试的有利工具
	提供流程实例启动功能
	提供按用户的含多查询条件的任务列表
	提供流程的执行功能及执行流转图查看功能
	提供简单的流程代理、代办、协办的操作和调试功能

3.2.9 Process Statistic
	工作量统计
	流程实例执行时间统计
	环节执行时间统计
	流程实例规模统计
	任务回退统计
	流程及环节时效统计
	流程变更情况统计

3.2.10支持BPMN1.1规范
	支持BPMN1.1规范（BPMN：业务流程建模与标注 Business Process Model and Notation），所有的图元按照BPMN1.1的规范展示。

3.2.11 多租户
	新增支持多租户能力，多租户允许不同的组织或者应用在一个独立的BPS引擎中运行，不同租户间的流程数据相互隔离，互相不能访问，通过租户信息登录BPS提供的Workspace和Client可以管理和应用租户各自的流程。
	BPS Process Server（BPS流程引擎）支持多租户能力
	BPS Work Client（BPS流程客户端）支持多租户登录
	BPS Work Space 支持多租户的注册、多租户登录
	BPS Studio导出Par包支持关联租户信息

3.2.12 分布式事务
	在业务应用与BPS引擎分布式部署的情况下，业务应用与BPS引擎没有统一的事务管理，导致业务应用状态和BPS引擎状态不一致问题；分布式事务模块用于解决业务应用与BPS引擎数据状态不一致问题。
	BPS客户端API接口提供分布式事务API
	BPS WebService接口新增分布式事务API

3.2.13集中任务中心
	集中任务中心将各个应用中发起的任务集中到一个公共的地方展现，解决用户需要到多个应用中查询自己工作任务，集中任务中心是独立的组件，可以与BPS进行方便的集成。
	支持查询代办任务
	支持查询已办任务BPS
	支持与Portal集成
	代办任务URL支持变量

3.2.14通知抄送
	BPS对人工活动环节增加了通知、抄送功能，通知、抄送只是给相关人看一下，并不影响流程本身的流转。
	  通知到人、通知到角色
	  通知超时
	  通知提醒

3.2.15多工作项支持迭代变量
	人工活动环节支持根据迭代变量产生工作项。

3.2.16任务池
	BPS提供一种新的基于“任务池”的任务申领模式，支持高并发、高效的领取同质的任务能力。
	  支持多队列高效领取
	  支持跨池领取
	  超时回收任务
	  宕机接管任务

3.2.17支持Aris流程转换为BPS流程
	支持将Aris中梳理的流程图转换为BPS的流程图。
	
========================================

4. 产品新功能特性

4.1  新功能特性
EOS Platform 7.6 GA新增主要功能特性包括：
1）	开发版Server启动速度相比EOS Platform 7.5版本提升50%
2）	EOS项目支持Maven依赖与编译体系；
3）	提供macOS开发版；
4）	Spring框架升级到3.2.17版本；
5）	NUI新增支持图表控件（ECharts3）；
6）	增加系统快照功能，提高产品可维护性；
7）	组件升级：NUI、Coframe、BPFF组件升级到最新版本；
8）	新增3类数据库、2类应用服务器、3类操作系统支持，提升平台的适应性；
9）	提升产品安全性，解决JDK反序列化漏洞，SQL注入，XSS跨站脚本攻击，CSRF跨站请求伪造等安全漏洞；
完整功能清单请参见下面章节。
4.1.1  基础环境升级
 	新增Oracle12c、MySQL5.6.33、DB2 9.7数据库支持
 	新增Weblogic12c、Tomcat8.5.5支持
 	开发版新增支持Windows 10 、macOS Sierra10.12.1操作系统
 	企业版新增支持Red Hat Enterprise Linux 7.2 
 	支持在Oracle JDK1.7.0_80运行，向前兼容Oracle JDK1.6/1.5
4.1.2	新增和优化的重要功能
 	EOS项目支持Maven方式编译和打包，并提供Maven私服仓库包和搭建指南；
 	新增系统快照功能，可以通过Governor方便的将应用和Web服务器的配置打包下载，辅助运维快速定位问题
 	NUI新增ECharts 3的图表控件，极大的丰富了NUI前端数据展现形式
 	优化了定时调度框架运行机制，解决了集群下任务不触发和调度器死锁的问题
 	升级Spring版本到3.2.17
 	优化开发版Server启动性能，相比7.5版本Server启动速度提升50%
 		测试机1：MacBook Pro i5 CPU版本，Server启动约10s（如远大于此参考值请到《EOS Platform7.6 产品安装指南》附录FAQ.11中查看解决方案）
 		测试机2：Windows PC i5 4210H CPU 、7200rmp机械硬盘，Server启动时间约30s（7.5开发版启动65s）
4.1.3提升平台安全性
 	产品默认安装了JDK反序列化远程执行命令的致命漏洞补丁
 	通过AppScan9.0安全扫描，采用AppScan9.0默认策略包含SQL注入、XSS跨站脚本攻击、CSRF跨站请求伪造、不充分账户封锁等等，详细报告参见文档《Platform7.6_Default_安全报告》、《Platform7.6_Workspace_安全报告》、《Platform7.6_Governor_安全报告》
4.1.4 BPFF流程快速实施框架升级到最新版本3.0.1，新增功能包括
 	支持细粒度相关数据
 	支持记录业务日志
 	新增表单加载API
 	支持选人选机构按条件检索
 	提供流程引擎操作日志对外API
 	新增流程组件：暂存、领取、代办、协办、终止、图示、操作日志
 	新增功能向导：单表功能向导、主从表功能向导
4.1.5 NUI框架升级到最新3.3.2，新增功能包括
 	新增消息提示框mini.showTips方法。
 	新增年月选择框monthpicker。
 	新增Grid控件onlyCheckSelection属性。
 	新增combobox/treeselect拼音过滤字段pinyinField
 	优化表格锁定时左右高度同步
 	优化fileupload上传进度显示效果
 	优化树的大数据量+懒加载时的BUG
 	优化在IE10\11下的一些展现效果
 	优化了控件的内存和性能表现
 	修复examples中带的oracle脚本执行报错
 	修复双击菜单新增tab页在关闭后，系统内存不释放
 	修复使用dateFormat设置时间格式，设置为yyyy-MM-dd HH:mm:ss时，页面显示不正确即yyyy-MM-dd
 	集成ECharts 3的图表控件，极大的丰富了前端数据展现形式
4.1.6 Coframe框架升级到4.0.1，新增功能包括
 	提供初始化用户和角色，可以不同的权限登录并可与Workspace菜单目录权限互通
 	增加对角色设置可管理工作组的功能
 	去除授权管理中岗位和员工TAB页，将机构和工作组TAB功能改为设置可管理机构/工作组
 	调整机构/工作组/岗位/员工授予角色权限的功能入口统一为：组织机构管理->各节点下的权限配置TAB页
 	去除之前版本中员工详细页面里设置可管理机构的功能

4.2  修复JIRA和Bug列表

 	JIRA：EOSPLATFORM-52   在studio中启动weblogic控制台输出乱码	
 	JIRA：EOSPLATFORM-48   新建项目，user-local-config.xml中默认的DefaultAppName还是eos-default； 
 	JIRA：BPSP-312   BPS6.7查询待办已办等查询接口，能够扩展一个参数来设置排序字段
 	JIRA：BPSP-303   BPS6.7流程图显示方面，增加流程超时后图标特别颜色标注
 	JIRA：BPSP-295   SCE中流程编辑器人工开始活动支持多表单需求
 	BUG： 47655	  IE11中，workspace中，业务目录管理中，选择一个目录，点击修改，弹出修改业务目录菜单问题 	 	 
 	BUG： 47654	  Firefox49浏览器登录workspace，业务流程管理的流程详情界面中【删除流程】、【取消流程发布】按钮点击无反应 	 	 
 	BUG： 47653	  sysadmin登录BPS work client后台异常 	 	 
 	BUG： 47652	  IE10,数据库连接页面滚动条布局不正确 	 	 
 	BUG： 47651	  Centos,JBoss6.1.0,sqlServer2012环境，添加缓存，“支持集群”复选框不能勾选 	 	 
 	BUG： 47650	  多次操作governor的“JMX安全控制”“HTTP安全控制”功能界面中勾选安全控制，点击【确定】界面刷新后安全控制显示没有勾选 	 	  	 
 	BUG： 47648	  Centos,JBoss6.1.0,sqlServer2012环境，点击“生成系统快照”没反应，后台报错 	 	 
 	BUG： 47647	  Firefox浏览器选中菜单栏后，添加定时器界面下拉右侧滚动条，无法显示【增加】、【返回】按钮 	 	 
 	BUG： 47645	  Governor英文界面，出现中文，见截图。 	 	 
 	BUG： 47643	  workspace，流程管理监控>>Web服务查看，Chrome和IE11滚动条拉到最后，记录无法显示全，见截图。IE8正常。 	 	 
 	BUG： 47642	  Governor中，BPS引擎配置，修改配置需要重启服务的说明样式建议改为一致的红色：参见“多租户” 	 	 
 	BUG： 47640	  wokrspace中，统一流程平台出现在业务定制与管控中 	 	 
 	BUG： 47639	  Workspace中管理员登录，业务流程中菜单重复 	 	 
 	BUG： 47638	  weblogic12c,db29.7 哑安装报错 	 	 
 	BUG： 47637	  workspace无法登录 	 	 
 	BUG： 47636	  执行自动化用例，发现com.primeton.foundation.DataContextUtil.sort方法排序错误 	 	 
 	BUG： 47635	  在linux、Websphere8.5、oracle12c环境下哑安装，启动后coframe登录报调用异常，workspace用sysadmin/000000据源及增加、修改类功能报调用异常 	 	 
 	BUG： 47633	  Mac版本，菜单[帮助]〉[安装新软件],功能无法使用。见截图。 	 	 
 	BUG： 47632	  Mac版本，SVN插件未安装，导致总是弹出安装插件的提示窗口。 	 	 
 	BUG： 47631	  Mac版本，在线帮助无法察看。 	 	 
 	BUG： 47628	  EOS_PLT_PE-Centos7.2,Mysql5.6.33,JBoss6.1,Chrome54:stopserver.sh无法停掉jboss进程 	 	 
 	BUG： 47625	  新建用户，赋予流程配置权限后，无法登录workspace 	 	 
 	BUG： 47624	  箱线图无法显示，后台抛异常 	 	 
 	BUG： 47623	  win10哑安装,创建快捷图标失败 	 	 
 	BUG： 47622	  platform7.6与jboss6.1中的xalan-2.5.0.jar包冲突 	 	 
 	BUG： 47621	  在jboss哑安装时，报“命令语法不正确” 	 	 
 	BUG： 47617	  Maven转换向导界面，选择一个空local的setting文件，修改本地库地址，点击完成报错 	 	 
 	BUG： 47616	  Maven转换页面，建议将“使用本地EOS库”修改为“导入本地EOS库” 	 	 
 	BUG： 47615	  给用户授系统管理员权限无法登录workspace 	 	 
 	BUG： 47614	  验证补丁‘业务目录权限有限’，给用户授流程管理员权限，用户登录workspace看不到目录下创建的菜单只能看到根节点 	 	 
 	BUG： 47613	  BPS work clinet用户无法登录 	 	 
 	BUG： 47612	  验证补丁PLATFORM_7.2_BPS_20150717_P1时，给业务目录批量授权时选择参与者报500错误 	 	 
 	BUG： 47611	  Governor添加主键数据源,提示"调用异常,请查看日志!" 	 	 
 	BUG： 47610	  [自动化】如果（开始、子流程）有若干个满足条件的连接线，子流程优先级比自动活动的高 	 	 
 	BUG： 47609	  拖拽图表控件，自动生成的代码建议format一下 	 	 
 	BUG： 47608	  漏斗图的宽度太大，导致图片有种被拉伸的感觉 	 	 
 	BUG： 47607	  验证补丁PLATFORM_7.5_CAP_20150813_P2场景时，coframe中的权限管理-流程配置-配置，当前流程界面中流程图无法显示、显示的版本号与发布的版本号不一致 	 	 
 	BUG： 47605	  Echarts控件名称建议统一，例如有些控件名称后面带Chart，有些没有，另外建议名称不要自己随便起，参考官网名称，与官网上的英文名称保持一致 	 
 	BUG： 47603	  MacOS Sierra 10.12.1，Studio.sh文件的执行权限不对，导致无法运行。 	 	 	 	 
 	BUG： 47601	  MacOS Sierra 10.12.1，安装介质，向导界面文字排版需要调整。见解图。 	 	 
 	BUG： 47599	  在Governor中勾选“自动启动调度器”，user-config.xml中schedule的时间配置被删除 	 	 
 	BUG： 47598	  在MySql中Timestamp类型的字段，如果为null，在eos中查询时会报错 	 	 
 	BUG： 47597	  Mysql数据库的列定义的DateTime数据类型，在eos拖拽生成数据集时，会自动为Date类型，Date类型插入数据库时，会自动截取掉时分秒 	 	 
 	BUG： 47596	  Studio的Mac安装介质建议为pkg或者dmg,目前这种类似linux的怪怪的 冀博 	 
 	BUG： 47595	  EOS开发版哑安装成功，governor管理应用默认default应用错误 	 	 
 	BUG： 47591	  SCE预览流程提示"调用异常,请查看日志！" 	 	 
 	BUG： 47584	  按照Nexus介质包搭建，新建基础项目，转换Maven成功后，有其他错误 	 	  
 	BUG： 47582	  英文版下，选择不匹配的xml,提醒不准确 	 	 
 	BUG： 47581	  转换Maven工程，从选择构建包一直返回到Maven工程向导界面，选择格式不准确的xml,无提示 	 	 
 	BUG： 47580	  需要修修改系统日志中的的部分记录级别默认值 	 	 
 	BUG： 47579	  转换成功后，第二次转换为Maven项目，使用本地EOS库仍勾选 	 	 
 	BUG： 47578	  Maven转换页面，xml格式不匹配提醒，在选择正确的xml后，提醒仍存在 	 
 	BUG： 47572	  基础版、企业版、标准版安装时到点击【安装】步骤报系统异常 	 	 
 	BUG： 47571	  验证补丁coframe_3.1.1_20151123_P1场景，问题未修复 	 	 
 	BUG： 47564	  安装目录下包含SCE相关jar包 	 		 
 	BUG： 47559	  开发版介质包中包含SCE相关jar包 	
 	BUG： 47553	  Maven向导界面“浏览”无法导入本地库的问题 	 
 	BUG： 47551	  Governor用户名长度限制必须大于6，导致新增用户无法登录 	 	 
 	BUG： 47549	  Governor新增数据源配置,提示"调用异常,请查看日志!" 	 	 
 	BUG： 47546	  按照搭建文档中搭建Nexus，启动Nexus报错 	 	 
 	BUG： 47545	  新增用户失败，数据库插入数据异常 	 	 
 	BUG： 47541	  新增角色失败，数据库插入数据异常 	 	 
 	BUG： 47538	  bpsconfig的角色描述不正确 	 	 
 	BUG： 47534	  Spring初始化带注解的Bean时抛空指针 	 	 
 	BUG： 47531	  EOS platform7.6开发版安装时DB2 9.7数据库初始化失败 	 
 	BUG： 47527	  EOS Platform7.6开发版安装时数据库选择oracle 12c初始化失败 	 	 
 	BUG： 47525	  Maven转换向导页面中，选择非setting文件后，修改本地库地址仍可勾选 	 	 
 	BUG： 47524	  格式不匹配的Setting.xml导入后，无任何提示，可直接点击完成 	 	 
 	BUG： 47523	  未配置本地库，Maven转换页面默认按钮问题 	 	 	 
 	BUG： 47501	  Maven转换向导界面大小写转换问题 	 	 
 	BUG： 47495	  开发版安装时，配置数据库界面数据库类型没有Mysql5.6.33，Oracle 12c、DB2 9.7版本的选项 	 	 
 	BUG： 47491	  Coframe用户管理列表有重复的用户名 	 	 
 	BUG： 47490	  转换Maven工程向导界面，输入包含特殊字符的路径，无任何提示 	 	 
 	BUG： 47489	  转换为Maven工程向导界面使用本地库未汉化


4.3  兼容性

	兼容EOS Platform 7.5

========================================

5. 联系方式：

	您可以通过以下方式与我们联系并进行沟通
	
	公司网址：http://www.primeton.com
	总机：86-21-50805188
	销售热线：400-820-5821
	售后服务热线：800-820-5821
	产品服务社区：http://p.primeton.com


普元信息技术股份有限公司 
Primeton Information Technologies, Inc.
----------------------------------------------
中国上海张江高科技园区碧波路456号中科大上海研发中心4F
4F, 456 Bibo RD., Shanghai, 201203, P. R. China

Copyright © 2003-2016 普元信息技术股份有限公司 版权所有
