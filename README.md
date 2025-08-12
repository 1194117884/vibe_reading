# vibe_reading


从阅读到记忆的无缝工作流：集成式语言学习应用深度解析报告


第一部分：解构理想的语言习得生态系统

为了全面评估当前市场上的解决方案，我们首先需要构建一个“黄金标准”——即理想中的语言学习应用应该具备的核心功能与设计原则。这个蓝图将用户在阅读英文书籍时遇到的痛点转化为一套完整的产品架构，旨在实现从单词捕捉到长期记忆的无缝衔接。

1.1 无中断沉浸式原则：交互摩擦的认知成本

用户的核心困境并非简单的“不方便”，而是一种对学习效率造成实质性损害的认知障碍。在认知心理学中，“认知负荷”指的是执行特定任务时，工作记忆所承受的压力。用户当前的工作流程——在Apple Books、词典应用和笔记应用之间频繁切换——极大地增加了认知负荷，并破坏了高效学习所必需的“心流”（Flow）状态。每一次中断都迫使大脑脱离阅读情境，完成一系列与阅读无关的操作，然后再艰难地重新沉浸到原文中去。
理想的应用，其首要价值在于消除这种交互摩擦，使单词学习成为阅读过程的自然延伸，而非干扰。市场对此已有清晰的认知，许多应用在宣传中都强调了这一点。例如，“阅界”App追求“流畅无障碍阅读” 1，“ClipIt”则标榜“学习不打断阅读节奏” 3。这些应用的定位直接印证了用户的核心痛点是一个被广泛认可的市场需求，也说明开发者社群对于这一用户群体的需求有着成熟的理解。用户的困扰并非个例，而是代表了一个亟待被满足的目标市场。

1.2 从捕捉到卡片的自动化知识摄取流程

理想的应用需要提供高效且智能的输入机制，将生词无缝转化为可供复习的知识卡片。
文本选择（划词）：当用户在Apple Books等阅读器中长按并选择一个单词或短语时，系统应能通过共享菜单（Share Sheet）或扩展插件，立即弹出一个包含翻译和“一键收藏”按钮的窗口。
图像/截图识别（OCR）：对于扫描版PDF或文本无法直接选择的场景，用户截取屏幕后，系统应能通过通知或常驻工具栏，让用户快速框选包含生词的区域。应用内置的OCR（光学字符识别）引擎会自动提取文本、提供翻译，并允许用户一键保存。
“黄金记录”的生成：一旦用户选择保存，系统应自动创建一张信息丰富的“闪卡”（Flashcard）。这张卡片是核心数据对象，必须包含以下元素，以满足用户“看到记录这个单词时的原截图或复制的文本”以及“看到时间和软件”的精细化需求：
原始词汇：用户选中的单词或短语。
翻译释义：精准的目标语言翻译。
原文语境：生词所在的完整句子，这对于理解词义至关重要。
原始快照：一张裁剪后的截图或对原文格式的复现，直观地还原单词出现的视觉环境。
元数据：包括来源（如书名）、记录时间戳和来源应用（如Apple Books）。

1.3 智能强化引擎：超越传统的遗忘曲线

一个简单的、基于艾宾浩斯遗忘曲线的复习提醒功能，已成为现代背单词应用的基础配置。然而，一个专家级的系统需要更加智能和个性化。
基于间隔重复（Spaced Repetition System, SRS）的算法：这是经过科学验证的高效记忆方法，构成了智能复习的核心。市面上众多优秀应用，如AnkiApp、WordUp、Linga等，都采用了SRS算法 4。
算法的个性化：理想的系统应超越固定的复习周期。它需要利用AI追踪用户对每个单词的回答情况（正确、错误、反应时间等），为每一个词汇建立独立的记忆曲线。正如“单词块”App所描述的，系统会评估用户对每个单词的掌握程度，并在最恰当的时间安排复习 9。同时，系统应能像“ClipIt”一样，智能推送用户的“薄弱词”，以实现高效攻克 3。
AI增强的语境理解：AI的角色不应局限于复习调度。更高级的应用会利用大语言模型来丰富学习体验。例如，“ClipIt”集成了通义千问模型，提供更易懂的“语境化解释” 3；而“WordUp”则能从电影、新闻、名言等真实语料中提取例句，帮助用户在真实场景中理解单词用法 4。

1.4 统一的苹果生态系统：发挥各平台独特优势

理想的应用应能深度整合苹果生态，实现用户“多端同步特殊利用”的期望。
核心原则：iCloud同步。所有用户的词库、学习进度、笔记和设置，都必须通过iCloud在所有设备间无缝、自动地同步。这一点在用户评论中被反复提及为关键需求 2，并且部分应用已经实现 10。
iPhone/iPad：作为主要的阅读和单词捕捉设备，其体验应为触控操作深度优化。
macOS：定位为“效率中心”。用户可以在Mac上进行更复杂的管理任务，如批量编辑词汇、通过Wi-Fi导入或导出自定义词库（如“生词本”App所支持的功能）11，甚至可以与“Bob” 12 或“iOCR” 13 这类系统级工具联动，从任何地方捕捉单词。
Apple Watch：定位为“微学习”设备。其价值不在于深度学习，而在于利用碎片化时间进行快速复习。功能可包括：
表盘复杂功能（Complication），实时显示待复习单词数量。
根据SRS算法推送复习通知，这正是用户所期望的。
一个简洁的Watch App，让用户在排队等候时能快速回顾5-10个单词。市面上已有如“Moca” 10 和“Daily背单词” 14 等应用支持Apple Watch。此外，“小鹿查单词”所具备的Siri查词功能，也能在手表端发挥巨大作用 15。

第二部分：市场现状分析：现有方案与策略性妥协

在定义了理想标准之后，本部分将对市场上的现有应用进行深入的竞争性分析，评估它们与理想蓝图之间的差距。分析发现，没有任何单一应用能完美满足用户“在Apple Books内无缝使用”的需求。这背后反映出市场的根本性分野：解决方案要么是功能全面的“集成式阅读环境”，要么是灵活但集成度较低的“通用型效率工具”。这种分野并非偶然，而是苹果操作系统设计理念的直接产物，它限制了第三方应用深度修改Apple Books等原生应用体验的能力。因此，用户所构想的“完美应用”在当前技术框架下难以实现，这迫使市场提供了两种各有利弊的替代路径，用户必须在二者之间做出战略性选择。

2.1 类别一：集成式阅读环境（“围墙花园”方案）

这类应用提供了最流畅的内部工作流，但要求用户放弃原有的阅读器（如Apple Books），将电子书导入其应用内部进行阅读。
Linga & duoBooks：这两个应用是该类别的杰出代表。它们都支持用户导入自己的EPUB或PDF文件 。在应用内阅读时，可以实现即点即译 ，并将生词连同其上下文例句一同保存到内置的、基于SRS算法的闪卡系统中 。Linga的用户评论明确赞赏其能够在上下文中学习单词并保存以供后续复习的功能 5。
阅界 (Yuejie)：这款应用与Linga类似，同样专注于提供导入EPUB/PDF后的流畅阅读体验 1。它集成了点词翻译、整段翻译、生词本和笔记功能 2。有用户评论明确提出希望阅读进度和单词本能在不同设备间同步，这表明跨设备同步是用户的核心诉求之一 2。开发者也确认了导入书籍后即可支持点词查词 2。该应用兼容完整的苹果生态系统，包括iPhone、iPad、M1芯片的Mac以及Vision Pro 1。
Readlang：这是一个以网页为中心的服务，但其模式与上述应用异曲同工：在平台上阅读文章，点击单词进行翻译，被翻译的单词会自动成为闪卡以供复习 17。它通过网页、浏览器插件和移动应用的组合，展示了这种集成模式的跨平台潜力 17。

2.2 类别二：系统级捕捉工具（“通用型工具”方案）

这类应用足够灵活，可以配合包括Apple Books在内的任何阅读应用使用，但代价是集成感较弱，操作步骤更多。
Bob & iOCR (macOS)：这是两款功能强大的macOS桌面工具。它们本身不是阅读器，而是通过全局快捷键运行的效率应用 12。它们提供了“划词翻译”和“截图翻译”功能，完美匹配了用户对捕捉方式的需求。同时，它们会保存翻译历史记录，这可以看作是一个初级的生词本 12。它们的主要局限在于仅支持macOS，并且从翻译历史到专门的SRS应用的转化过程仍需手动操作。它们解决了“捕捉”问题，但未完全解决“记忆”问题。
ClipIt (iOS)：这款应用是通用型工具在iOS上的体现。其核心工作机制是监控系统剪贴板 3。用户在Apple Books中复制一个单词，然后切换到ClipIt，应用会自动识别剪贴板内容并进行处理。这是在iOS系统限制下，针对Apple Books等封闭应用的一种巧妙变通方案。该应用还宣称拥有AI深度解析和智能复习系统，满足了用户的另外两个关键需求 3。其主要缺点是需要“复制-切换应用”两步操作，虽然比用户当前流程快，但仍存在上下文切换的摩擦。

2.3 类别三：间隔重复（SRS）领域的专业应用

这类应用在用户需求的“记忆”环节做到极致，但在“捕捉”环节往往较为薄弱，需要依赖其他工具或手动输入。
Anki / AnkiMobile / AnkiApp：Anki是功能强大、高度可定制的SRS软件的黄金标准 18。然而，其用户体验被普遍认为复杂且不友好，卡片制作过程是其主要痛点 18。这种“Anki悖论”催生了一个庞大的辅助工具生态系统。
AnkiOCR：这是一个Anki插件，通过对卡片内的图片进行OCR识别来生成文本，直接满足了用户通过截图创建卡片的需求，证明了即便是最核心的SRS用户群体也对此功能有强烈需求 20。
AnkiApp：这是一个界面更友好、商业化的Anki替代品。它提供跨平台同步（iOS, macOS）、图文卡片制作和内置的SRS算法 。但它是一个独立的生态系统，与Anki官方的AnkiWeb不兼容，且在硬核用户中存在争议 22。它本身也并未解决从Apple Books中直接捕捉单词的问题。
现代SRS替代品：诸如“单词块” 9、“WordUp” 4 和“疯狂背单词” 23 等应用，专注于提供比Anki更精美、更易用的SRS体验。它们通常采用更智能的AI算法 4 和现代化的界面设计。它们的核心功能是词汇复习，而非在阅读中捕捉，是其他工具捕捉到的生词的理想“归宿”。

表1：主流语言学习与捕捉应用功能对比矩阵

为了直观地比较各类解决方案，下表根据用户需求的关键维度，对市场上领先的应用进行了横向评估。
应用名称
主要功能
平台支持
应用内阅读 (EPUB/PDF)
划词翻译
截图/OCR翻译
剪贴板监控
语境保存 (句子/图片)
内置SRS
多端同步
与Apple Books集成
Linga
集成阅读器
iOS, iPadOS
✔️
✔️ (应用内)
❌
❌
✔️ (例句)
✔️
✔️
不适用 (独立应用)
duoBooks
集成阅读器
iOS, iPadOS
✔️
✔️ (应用内)
❌
❌
✔️ (平行文本)
✔️
未明确
不适用 (独立应用)
阅界
集成阅读器
iOS, iPadOS, macOS (M1+)
✔️
✔️ (应用内)
❌
❌
✔️ (笔记)
❌ (仅生词本)
待加强
不适用 (独立应用)
Bob
通用工具
macOS
❌
✔️ (系统级)
✔️ (系统级)
❌
❌
❌ (仅历史记录)
不适用
快捷键
iOCR
通用工具
macOS
❌
✔️ (系统级)
✔️ (系统级)
✔️
❌
❌ (仅历史记录)
不适用
快捷键
ClipIt
通用工具
iOS, iPadOS
❌
❌
❌
✔️
❌
✔️
未明确
剪贴板
AnkiMobile
SRS应用
iOS, iPadOS, macOS
❌
❌
❌
❌
✔️ (手动添加)
✔️
✔️
需快捷指令
AnkiApp
SRS应用
iOS, iPadOS, macOS
❌
❌
❌
❌
✔️ (手动添加)
✔️
✔️
不支持
WordUp
SRS应用
iOS, iPadOS
❌
❌
❌
❌
✔️ (AI生成例句)
✔️
✔️
不支持


第三部分：利用原生工具与自定义工作流弥合差距

本部分将探讨一个核心问题：“我能否利用苹果自带的工具来构建理想的工作流？”我们将分析苹果原生功能的局限性，以及通过自动化工具进行弥补的可能性。

3.1 苹果原生工具集：功能强大但存在关键短板

苹果在其生态系统中提供了一系列强大的翻译和词典工具，但它们无法完全满足用户构建一个从阅读到记忆的闭环学习系统的需求。
内置“翻译”与“词典”：iOS自带的“翻译”应用和系统级词典功能可以提供快速的单词查询 24。“翻译”应用甚至可以将查询结果保存到“个人收藏” 24。然而，这些原生工具在用户的核心需求上存在三个致命缺陷：
无法保存语境：它们只能保存孤立的单词或短语，无法自动记录其所在的原始句子。
缺乏SRS机制：它们没有基于间隔重复的智能复习系统，“个人收藏”只是一个无序的列表，无法科学地安排复习。
数据孤岛：“个人收藏”列表是一个封闭的数据集，无法方便地导出或与其他专业的词汇管理应用联动。
“快捷指令”：DIY的桥梁：对于希望将Apple Books与专业SRS工具（如Anki）连接起来的用户而言，“快捷指令”（Shortcuts）是苹果官方提供的最强大的自动化工具。研究表明，构建一个从应用内选中文本到创建Anki卡片的工作流是技术上可行的 。
其基本流程是：在Apple Books等应用中选中文本后，通过系统的“共享”菜单触发一个自定义的快捷指令。
该快捷指令会接收到选中的文本，然后构建一个特殊的URL Scheme（如 anki://x-callback-url/addnote?...）来调用AnkiMobile应用 。
为了能被正确传递，选中的文本必须经过URL编码，然后嵌入到URL中，作为卡片正面或背面的内容 。
局限性：尽管可行，但这个过程也揭示了DIY方案的“隐性成本”。首先，它的设置过程相当复杂，需要用户理解URL Scheme的构造，甚至可能需要安装第三方辅助应用（如“Actions”）来处理URL编码等任务 26。其次，这种工作流非常“脆弱”，任何一方（iOS系统、Apple Books或AnkiMobile）的更新都可能导致其失效，需要用户不断进行维护。最后，虽然可以捕捉到单词，但要自动抓取完整的句子或书名等元数据则更为困难，甚至不可能。
ibooks_anki这个GitHub项目展示了一种在macOS上通过直接读取Books应用数据库来提取高亮内容的方法，这从侧面印证了实现这一目标的极端复杂性 27。

3.2 “缝合”方案 vs. 集成式应用：最终的战略抉择

这种通过“快捷指令”等工具自行搭建的解决方案，其本质是一种“缝合”——将多个独立的优质应用强行连接在一起。它虽然提供了极大的灵活性，但也带来了高昂的“DIY税”，包括投入的设置时间、持续的维护成本以及潜在的不稳定性。这种“税负”与用户追求无摩擦、无中断体验的初衷背道而驰。它只是将一种摩擦（手动复制粘贴）替换为了另一种摩擦（技术配置与维护）。
因此，用户面临一个清晰的战略抉择：
“缝合”工作流：在Apple Books中阅读 -> 选中生词 -> 运行自定义快捷指令 -> 在AnkiMobile中创建卡片 -> 在Anki生态中跨平台复习。
优点：可以使用自己偏爱的阅读器（Apple Books）和最强大的SRS工具（Anki）。
缺点：设置复杂，稳定性差，捕捉体验不够流畅，技术门槛高。
集成式工作流：将EPUB电子书导入Linga或阅界等应用 -> 在应用内阅读并直接点击生词进行翻译和收藏 -> 在该应用自带的复习系统中进行学习。
优点：极低的交互摩擦，体验无缝，一站式解决所有问题。
缺点：必须放弃Apple Books及其生态（如iCloud阅读进度同步、内置书店等）。

第四部分：前沿功能探索：悬浮窗与AI语境智能

在明确了现有市场的格局后，本部分将深入探讨您提出的两个极具前瞻性的功能构想，并分析其在苹果生态系统内的技术可行性。这两个构想分别指向了交互体验的极致优化和学习深度的革命性突破。

4.1 悬浮窗：实现真正的无缝捕捉

您设想的“以悬浮窗口形式常驻，自动访问剪贴板图片”功能，旨在彻底消除应用切换带来的摩擦。这在苹果的不同平台上具有不同的实现路径和挑战。
在macOS上：技术成熟，完全可行。macOS提供了强大的窗口管理能力，允许开发者创建“始终置顶”（Always-on-Top）的悬浮窗 6。像iTerm2这样的应用已经可以配置为浮动在所有其他窗口之上的热键窗口 28。同时，macOS应用可以轻松地在后台监控剪贴板的变动，无论是文本还是图片 15。因此，在Mac上开发一个集成了OCR功能的、始终悬浮的剪贴板助手是完全可行的，它可以实时捕捉用户复制的任何内容并提供快捷操作。
在iOS/iPadOS上：充满挑战的“巧妙 workaround”。与macOS不同，iOS和iPadOS出于安全和隐私的考量，对后台活动和窗口管理施加了严格的限制 30。
“真”悬浮窗的缺失：第三方应用无法在系统层面创建任意悬浮于其他应用之上的窗口 31。苹果提供的最接近的功能是画中画（Picture-in-Picture, PiP）和台前调度（Stage Manager）。
画中画 (PiP)：虽然最初为视频设计，但开发者已经巧妙地利用PiP API来保持应用在后台的“伪激活”状态 33。像Yoink和Pycopaste这样的剪贴板管理应用，正是通过启动一个微小的、可以被隐藏到屏幕边缘的PiP“视频”窗口，来实现在后台持续监控剪贴板的目的 22。这是目前在iOS上实现“自动访问剪贴板”最主流的变通方案，但它需要用户手动开启，且体验上仍是一种“hack”。
台前调度 (Stage Manager)：在支持的iPad型号上，台前调度允许更灵活的窗口布局和重叠，更接近桌面体验 38。用户可以创建包含多个应用窗口的工作区。然而，它依然不是一个可以覆盖在任何全屏应用之上的“全局”悬浮窗，而是一个独立的、受管制的窗口环境 40。

4.2 AI语境智能：从“闪卡”到“知识对话”

您提出的“将元截图内容集成到AI系统，可以复习时更加智能对话理解，类似于notebookLM”的构想，精准地把握了AI教育应用的未来方向：从简单的信息呈现转向深度的知识内化。
超越闪卡，迈向AI导师：传统的闪卡只解决了“是什么”（What）的问题（单词-释义）。而您的构想则引入了“为什么”（Why）和“怎么样”（How）的维度。当AI能够访问原始的截图（视觉语境）和句子（文本语境）时，它就不再是一个简单的复读机，而是一个可以进行苏格拉底式对话的AI导师。
应用场景：用户在复习时，可以不再局限于“回忆-判断”的单一模式，而是可以向AI提问：“根据这张截图的氛围，这个词是褒义还是贬义？”“用更简单的词解释一下这个句子里的用法？”“给我造一个和这个例句情绪相似的句子。”这完全契合了您最初对“意境”理解的需求。
技术核心：基于用户内容的AI（Grounding AI in Your Content）：这个想法与Google的NotebookLM的核心理念不谋而合。NotebookLM的核心能力就是成为用户所提供资料的“专家”，所有回答都基于用户上传的文档，并能提供引用来源 41。
实现路径：在技术上，这通常通过一种名为“检索增强生成”（Retrieval-Augmented Generation, RAG）的架构实现 11。系统首先从用户的知识库（在这里是包含截图、原文、释义的“黄金记录”）中检索最相关的信息，然后将这些信息作为上下文提供给大语言模型（LLM），指导它生成精准、忠于原文的回答。
市场趋势：这一模式正在成为AI学习工具的新浪潮。诸如Mindgrasp 43、Eduaide.AI 44、Flint 45 等应用，都允许用户上传自己的材料，并在此基础上与AI进行互动学习。而像Speak 17、Talkio AI 46 这样的语言学习应用，也正致力于打造更具交互性的AI对话伙伴。这证明您的构想不仅技术上可行，而且与市场最前沿的探索方向高度一致。

第五部分：战略性建议与未来展望

综合以上分析，本报告将提供具体的、可操作的建议，并对该领域未来的发展趋势进行预判。

5.1 近期行动建议：选择最适合您的妥协方案

不存在一个能够满足所有需求的“完美”应用。因此，最佳选择取决于用户的个人优先级。
方案一：若追求极致流畅、一站式的体验，并愿意更换阅读应用
核心推荐：Linga 或 阅界 1
。
理由：这两款应用在功能上最接近用户所描绘的理想蓝图。它们成功地将“导入阅读、即点即译、语境收藏、智能复习”这几个核心环节整合在同一个应用内，最大限度地降低了学习过程中的认知负荷。用户只需将EPUB等格式的电子书导入，即可享受无缝的学习体验。
方案二：若坚持使用Apple Books作为唯一阅读器，并愿意接受一定程度的操作不便
核心推荐：“缝合”式解决方案。
理由：这条路径拥抱了灵活性，但牺牲了便利性。具体配置如下：
在macOS上：使用 Bob 12 或
iOCR 13 进行划词和截图翻译，然后手动将重要单词整理到Anki中。
在iOS/iPadOS上：使用 ClipIt 3 的剪贴板监控功能进行快速捕捉，然后在ClipIt内置的SRS系统中复习；或者，对于技术能力较强的用户，可以尝试配置
快捷指令工作流 ，将单词直接发送到 AnkiMobile。

5.2 终极应用的蓝图

总结所有分析，一个能彻底解决用户痛点的“终极应用”应具备以下特质：
无缝捕捉：在macOS上，它是一个拥有全局悬浮窗的助手，能监控剪贴板并进行OCR识别。在iOS上，它巧妙利用**画中画（PiP）**机制实现后台剪贴板监控，并深度集成“共享”菜单和“快捷指令”，最大限度减少应用切换。
智能制卡：一键将生词、释义、原文句子和原始截图打包成一张“黄金记录”卡片，并自动附上来源、时间等元数据。
AI对话式复习：它不仅仅是一个SRS复习工具，更是一个AI知识伙伴。用户可以随时就某张卡片与AI展开对话，AI的回答将严格基于卡片中的图文语境，实现对“意境”的深度理解和探究。
苹果生态深度整合：所有数据通过iCloud在iPhone, iPad, Mac, Watch之间无缝同步。Apple Watch应用专注于碎片化时间的快速复习，并提供表盘复杂功能和Siri集成。
目前，在iOS上实现这一蓝图的最大障碍是系统对后台任务和窗口管理的严格限制。在苹果提供更开放的API之前，完美的无缝体验仍需依赖巧妙的变通方案。

5.3 市场机遇与最终结论

本报告的分析清晰地表明，一个面向高阶、自主型语言学习者的效率工具市场虽然小众，但确实存在且价值巨大。未来的竞争焦点将不再是简单的翻译或词典功能，因为这些已经高度商品化。
下一代语言学习工具的决定性特征将是AI驱动的、深度语境感知能力。您在查询中提到的对“意境”（context and mood）的捕捉，以及后续提出的“类似NotebookLM”的对话式学习构想，正是一种对未来趋势的前瞻性洞察。简单的词汇表已经无法满足需求，用户渴望的是对知识的深层理解和高效内化。应用的价值创造正从“提供翻译”转向“提供理解”。未来的领先者，将不再是最好的“词典”，而是最智能的“AI学习教练”，它能够自动化地从阅读材料中提取知识，并以最高效、最个性化的对话方式帮助用户将其转化为长期记忆。
引用的著作
ClipIt - 学英语必备生词本App ，查询保存记单词 - App Store, 访问时间为 七月 8, 2025， https://apps.apple.com/br/app/clipit-%E5%AD%A6%E8%8B%B1%E8%AF%AD%E5%BF%85%E5%A4%87%E7%94%9F%E8%AF%8D%E6%9C%AC-app-%E6%9F%A5%E8%AF%A2%E4%BF%9D%E5%AD%98%E8%AE%B0%E5%8D%95%E8%AF%8D/id6740757080?l=en-GB
WordUp | AI Vocabulary Builder - Google Play 上的应用, 访问时间为 七月 8, 2025， https://play.google.com/store/apps/details?id=co.wordupapp.app&hl=zh
App Store 上的“单词块-背单词学英语翻译”, 访问时间为 七月 8, 2025， https://apps.apple.com/cn/app/%E5%8D%95%E8%AF%8D%E5%9D%97-%E8%83%8C%E5%8D%95%E8%AF%8D%E5%AD%A6%E8%8B%B1%E8%AF%AD%E7%BF%BB%E8%AF%91/id1529999429
How to Automate Anki Card Creation from Clipboard Text Using iOS Shortcuts and ChatGPT, 访问时间为 七月 8, 2025， https://www.reddit.com/r/medicalschoolanki/comments/1dwf84b/how_to_automate_anki_card_creation_from_clipboard/
Automatically create card from selected text with Siri Shortcuts ..., 访问时间为 七月 8, 2025， https://forums.ankiweb.net/t/automatically-create-card-from-selected-text-with-siri-shortcuts/23020
Keep a window always on top in Mac OS X - Super User, 访问时间为 七月 9, 2025， https://superuser.com/questions/182016/keep-a-window-always-on-top-in-mac-os-x
Apple should fix the Clipboard on iOS to make accessing it require Permission. This is a massive opening for malicious apps. - Reddit, 访问时间为 七月 9, 2025， https://www.reddit.com/r/apple/comments/4nl861/apple_should_fix_the_clipboard_on_ios_to_make/
How Many of you Actually Use Stage Manager? : r/iPadPro - Reddit, 访问时间为 七月 9, 2025， https://www.reddit.com/r/iPadPro/comments/1czhblb/how_many_of_you_actually_use_stage_manager/
App Store 上的“阅界-英语读书” - Apple, 访问时间为 七月 8, 2025， https://apps.apple.com/cn/app/%E9%98%85%E7%95%8C-%E8%8B%B1%E8%AF%AD%E8%AF%BB%E4%B9%A6/id1613051432
iPhone自带词典不显示 - Apple 社区, 访问时间为 七月 8, 2025， https://discussionschinese.apple.com/thread/255317752
Conversational AI Language Learning Apps in Edtech - Ecosmob, 访问时间为 七月 9, 2025， https://www.ecosmob.com/conversational-ai-language-apps-edtech/
Moca-属于自己的记忆本 - App Store, 访问时间为 七月 8, 2025， https://apps.apple.com/cn/app/moca-%E5%B1%9E%E4%BA%8E%E8%87%AA%E5%B7%B1%E7%9A%84%E8%AE%B0%E5%BF%86%E6%9C%AC/id1490969385
Linga: Books with translations 9+ - App Store, 访问时间为 七月 8, 2025， https://apps.apple.com/us/app/linga-books-with-translations/id1525101819
iOCR-OCR截图识字与截图翻译划词翻译工具4+ - App Store, 访问时间为 七月 8, 2025， https://apps.apple.com/cn/app/iocr-ocr%E6%88%AA%E5%9B%BE%E8%AF%86%E5%AD%97%E4%B8%8E%E6%88%AA%E5%9B%BE%E7%BF%BB%E8%AF%91%E5%88%92%E8%AF%8D%E7%BF%BB%E8%AF%91%E5%B7%A5%E5%85%B7/id6463065047?mt=12
CopyClip - Clipboard History on the Mac App Store - Apple, 访问时间为 七月 9, 2025， https://apps.apple.com/tr/app/copyclip-clipboard-history/id595191960?mt=12
Linga: Books with translations - Apps on Google Play, 访问时间为 七月 8, 2025， https://play.google.com/store/apps/details?id=io.linga
Speak - The language learning app that gets you speaking, 访问时间为 七月 9, 2025， https://www.speak.com/
Creating Anki flashcards on iOS - DEV Community, 访问时间为 七月 8, 2025， https://dev.to/lobk/creating-anki-flashcards-on-ios-2i2m
Seeking MUCH simpler alternative to ANKI - Help, 访问时间为 七月 8, 2025， https://forums.ankiweb.net/t/seeking-much-simpler-alternative-to-anki/51570
Mac App Store 上的“Bob - 翻译和OCR 工具”, 访问时间为 七月 8, 2025， https://apps.apple.com/cn/app/bob-%E7%BF%BB%E8%AF%91%E5%92%8C-ocr-%E5%B7%A5%E5%85%B7/id1630034110?mt=12
墨墨背单词- 高效抗遗忘，轻松规划海量词汇记忆。, 访问时间为 七月 8, 2025， https://www.maimemo.com/
Yoink Brings Background Clipboard Monitoring to iOS and iPadOS ..., 访问时间为 七月 9, 2025， https://www.macstories.net/ios/yoink-brings-background-clipboard-monitoring-to-ios-and-ipados-15-via-picture-in-picture-workaround/
duoBooks: Read & Translate 12+ - App Store, 访问时间为 七月 8, 2025， https://apps.apple.com/us/app/duobooks-read-translate/id1538452253
阅界-英语读书٤+ - App Store, 访问时间为 七月 8, 2025， https://apps.apple.com/eg/app/%E9%98%85%E7%95%8C-%E8%8B%B1%E8%AF%AD%E8%AF%BB%E4%B9%A6/id1613051432?l=ar
阅界-英语读书 - App Store, 访问时间为 七月 8, 2025， https://apps.apple.com/ru/app/%E9%98%85%E7%95%8C-%E8%8B%B1%E8%AF%AD%E8%AF%BB%E4%B9%A6/id1613051432
Creating Anki card from iOS books app - Reddit, 访问时间为 七月 8, 2025， https://www.reddit.com/r/Anki/comments/1hacimf/creating_anki_card_from_ios_books_app/
Clips : Clipboard Manager on the Mac App Store - Apple, 访问时间为 七月 9, 2025， https://apps.apple.com/us/app/clips-clipboard-manager/id1401930621?mt=12
Any way to keep a window on top of other - Apple Support Community, 访问时间为 七月 9, 2025， https://discussions.apple.com/thread/253474519
p0deje/Maccy: Lightweight clipboard manager for macOS - GitHub, 访问时间为 七月 9, 2025， https://github.com/p0deje/Maccy
iOS App Security 101 - Medium, 访问时间为 七月 9, 2025， https://medium.com/mobilepeople/ios-app-security-101-62f20b6640ba
Creating a True Floating Window (Overlay) in Flutter (Android & iOS) - Not Picture-in-Picture, 访问时间为 七月 9, 2025， https://stackoverflow.com/questions/79533317/creating-a-true-floating-window-overlay-in-flutter-android-ios-not-pictu
Has anyone found a way to float apps inside a floating window/pop-up window/PIP/freeform window, without root? (I'm trying to put Aard2 into one) : r/Onyx_Boox - Reddit, 访问时间为 七月 9, 2025， https://www.reddit.com/r/Onyx_Boox/comments/wicnrb/has_anyone_found_a_way_to_float_apps_inside_a/
All the Apps That Work with Picture in Picture (PiP) on Your iPhone, 访问时间为 七月 9, 2025， https://ios.gadgethacks.com/how-to/all-apps-work-with-picture-picture-pip-your-iphone-0323206/
Picture in Picture – multitasking with video overlays in iOS 14 - TapSmart, 访问时间为 七月 9, 2025， https://www.tapsmart.com/tips-and-tricks/picture-picture-multitasking-video-overlays-ios-14/
Clipboard Manager - Pycopaste on the App Store, 访问时间为 七月 9, 2025， https://apps.apple.com/us/app/clipboard-manager-pycopaste/id1635345871
Pycopaste: Clipboard manager app for iPhone and Mac : r/apple - Reddit, 访问时间为 七月 9, 2025， https://www.reddit.com/r/apple/comments/162m6sc/pycopaste_clipboard_manager_app_for_iphone_and_mac/
How I manage my clipboard history on iPhone and iPad | by ldstephens - Medium, 访问时间为 七月 9, 2025， https://ldstephens.medium.com/how-i-manage-my-clipboard-history-on-iphone-and-ipad-f0da72235dfa
Move, resize, and organize windows with Stage Manager on iPad - Apple Support, 访问时间为 七月 9, 2025， https://support.apple.com/guide/ipad/move-resize-and-organize-windows-ipad1240f36f/ipados
iOS and iPadOS 17: The MacStories Review - Page 6 of 17, 访问时间为 七月 9, 2025， https://www.macstories.net/stories/ios-and-ipados-17-the-macstories-review/6/
Stage Manager not Working Properly and wi… - Apple Support Community, 访问时间为 七月 9, 2025， https://discussions.apple.com/thread/254705900
11 Best AI Tools for Students in 2025: (Free + Paid) | Top Apps for Your Learning Needs, 访问时间为 七月 9, 2025， https://elephas.app/blog/ai-tools-for-students
11 ways Google AI can help educators and students in 2025, 访问时间为 七月 9, 2025， https://blog.google/outreach-initiatives/education/ai-tools-education-2025/
Mindgrasp - #1 AI Learning Platform For Students and Professionals, 访问时间为 七月 9, 2025， https://www.mindgrasp.ai/
Eduaide.Ai: AI Created for Teachers, 访问时间为 七月 9, 2025， https://www.eduaide.ai/
Flint - AI for schools, 访问时间为 七月 9, 2025， https://www.flintk12.com/
Talkio AI | Practice Language with AI, 访问时间为 七月 9, 2025， https://www.talkio.ai/
