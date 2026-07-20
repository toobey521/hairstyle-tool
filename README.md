# ✂️ Toobey 发型设计助手

> 上传照片 → AI 分析脸型 → 智能推荐发型 → 批量生成高清效果图  
> 支持云端 API 和本地 ComfyUI（IP-Adapter FaceID 保留面部特征）

---

## 🌐 在线地址

| 页面 | 链接 |
|------|------|
| 🏠 **下载页**（介绍+下载按钮） | https://toobey521.github.io/hairstyle-tool/ |
| ✂️ **在线使用** | https://toobey521.github.io/hairstyle-tool/hairstyle.html |
| 📂 GitHub 仓库 | https://github.com/toobey521/hairstyle-tool |

---

## ✨ 功能特色

- **📸 照片上传** — 拖拽或点击上传正面人像，支持 JPG/PNG
- **🧠 AI 脸型分析** — 多服务商视觉模型（DeepSeek/OpenAI/通义/智谱等）分析脸型并推荐发型
- **🎨 批量生图** — 每款发型可选 3/5/10 张，支持云端 API 或本地 ComfyUI
- **👤 面部保留** — ComfyUI 模式下使用 **IP-Adapter FaceID** 保留面部特征，换发不换脸
- **🔧 多服务商** — DeepSeek / OpenAI / Anthropic / 通义千问 / 智谱 GLM / 月之暗面 / 阶跃星辰 / Agnes 一键切换
- **🌙 暗色 UI** — 专业暗色主题，图片点击放大，右键保存

---

## 🚀 使用方式

### 方式一：在线使用（无需安装）

1. 打开 https://toobey521.github.io/hairstyle-tool/hairstyle.html
2. 选择 AI 服务商（如 **Agnes**）
3. 填入 API Key → 点击「保存设置」→ 点击「测试连接」
4. 上传正面照片 → 设置性别/年龄
5. 点击「分析脸型 + 获取发型建议」
6. 每款发型选择数量 → 点击「批量生成」
7. 点击图片放大查看，右键另存为下载

> ⚠️ 在线版因 HTTPS 环境调用 HTTP 接口可能有跨域问题。如遇 fetch 报错，在设置面板勾选「跨域代理」。

### 方式二：本地 ComfyUI（保留面部特征，需要 GPU）

**需要先安装：**
- ComfyUI（https://github.com/comfyanonymous/ComfyUI）
- SDXL base 模型（`sd_xl_base_1.0.safetensors`）
- IP-Adapter FaceID 模型（`ip-adapter-faceid-plusv2_sdxl.bin` + 对应 LoRA）
- CLIP Vision 模型（`CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors`）
- InsightFace 模型（`antelopev2`）

**启动：**
```bash
# 双击启动
发型设计助手.vbs

# 或手动启动三个服务
cd ComfyUI && PYTHONPATH="" .venv/Scripts/python main.py --port 8189 --lowvram
cd Desktop && python -m http.server 18765
cd ComfyUI && PYTHONPATH="" .venv/Scripts/python Desktop/comfy_bridge.py
```

然后浏览器打开 http://localhost:18765/hairstyle.html

---

## 📁 文件说明

| 文件 | 说明 |
|------|------|
| `index.html` | GitHub Pages 下载页（介绍+下载按钮） |
| `hairstyle.html` | **主程序** — 单 HTML 文件，即下即用 |
| `发型设计助手.vbs` | Windows 一键启动脚本（启动 HTTP 服务+ComfyUI+桥接） |
| `发型设计助手-使用说明.docx` | 详细使用说明书（Word 版） |

### 仓库文件结构（完整版）

完整版涉及多个文件，参见本地项目：

```
Desktop/
├── hairstyle.html                  ← 主页面
├── 发型设计助手.vbs                ← 启动脚本
├── comfy_bridge.py                 ← ComfyUI 桥接服务
├── 发型设计助手-使用说明.md         ← 使用说明 Markdown 版
├── 发型设计助手-使用说明.docx       ← 使用说明 Word 版
├── uploads/                        ← 桥接图片缓存
└── 发型设计助手/
    ├── hairstyle.html
    └── 发型设计助手.vbs

ComfyUI/custom_nodes/
└── ComfyUI_IPAdapter_plus/         ← IP-Adapter 自定义节点

ComfyUI/models/
├── checkpoints/sd_xl_base_1.0.safetensors         6.9 GB
├── clip_vision/CLIP-ViT-H-14-*.safetensors         3.8 GB
├── ipadapter/ip-adapter-faceid-plusv2_sdxl.bin     1.4 GB
├── loras/faceid-plusv2_sdxl_lora.safetensors       354 MB
└── insightface/models/antelopev2/                  408 MB
```

---

## 🛠 支持的服务商

| 服务商 | 视觉分析 | 图片生成 | 免费额度 |
|--------|---------|---------|---------|
| **DeepSeek** | ✅ deepseek-vision | ❌ | 注册赠送 |
| **OpenAI** | ✅ GPT-4o | ✅ DALL-E 3 | 付费 |
| **Anthropic** | ✅ Claude Sonnet 4 | ❌ | 付费 |
| **通义千问** | ✅ Qwen-VL-Max | ❌ | 有免费额度 |
| **智谱 GLM** | ✅ GLM-4V-Plus | ✅ CogView-3 | 有免费额度 |
| **月之暗面** | ✅ Moonshot v1 | ❌ | 注册赠送 |
| **阶跃星辰** | ✅ Step-1V | ❌ | 注册赠送 |
| **Agnes** | ✅ agnes-2.0-flash | ✅ agnes-image-2.0-flash | 注册赠送 |
| **ComfyUI（本地）** | ❌（用上述API） | ✅ IP-Adapter FaceID | 免费（需 GPU） |

---

## 💻 技术架构

### ComfyUI 模式数据流

```
用户照片 → 前端压缩(512px) → 桥接服务(:5820)
    │
    ├── 预处理：裁切正方形 + resize 1024×1024
    ├── 上传到 ComfyUI
    ├── 提交 IP-Adapter FaceID Workflow
    │
    ├─ 1. LoadImage
    ├─ 2. CheckpointLoaderSimple → SDXL
    ├─ 3. IPAdapterUnifiedLoaderFaceID → FaceID 模型+LoRA+CLIP Vision
    ├─ 4. InsightFace 人脸检测 → 512维特征向量
    ├─ 5. IPAdapterFaceID → 面部特征注入 UNet
    ├─ 6. CLIPTextEncode → 正/负提示词
    ├─ 7. EmptyLatentImage → 1024×1024 潜空间
    ├─ 8. KSampler → 25步降噪
    ├─ 9. VAEDecode → 潜空间→像素
    └─ 10. SaveImage → 返回 Base64 给前端
```

### 关键参数

| 参数 | 值 | 说明 |
|------|-----|------|
| IP-Adapter weight | 1.2 | 面部特征注入强度 |
| weight_faceidv2 | 1.5 | FaceID v2 权重 |
| embeds_scaling | K+V | 特征嵌入方式 |
| CFG | 7.5 | 无分类器引导尺度 |
| Steps | 25 | 推理步数 |
| Sampler | euler | 采样器 |
| Resolution | 1024×1024 | SDXL 原生尺寸 |

---

## ❓ 常见问题

| 问题 | 解决 |
|------|------|
| **Failed to fetch** | 1) 选 ComfyUI 时桥接没启动 2) 跨域问题，勾选「跨域代理」 |
| **生成的人脸不像本人** | IP-Adapter FaceID 保留身份特征但非精确还原，上传清晰正脸照 |
| **"No face detected"** | 照片中没检测到人脸，换清晰正脸照，不要戴墨镜/口罩 |
| **生成速度太慢** | ComfyUI 模式第一张约 90s（冷启动），后续约 50-60s/张；改用云端 API 更快 |
| **按钮点击没反应** | 已修复：点击边缘或中间的空白区域都可触发 |
| **页面空白/JS 不执行** | 刷新页面（Ctrl+F5），或换浏览器 |
| **下载后双击没反应** | `.html` 需配合 HTTP 服务或 API Key 使用，纯双击不行 |

---

## 📜 更新日志

### v3.2 — 2026-07-20
- 🆕 加入 IP-Adapter FaceID 面部保留功能
- 🆕 桥接服务 comfy_bridge.py（预处理图片+FaceID workflow）
- 🆕 安装 cubiq/ComfyUI_IPAdapter_plus 自定义节点
- 🔧 修复 batchGen 不认 ComfyUI 路由
- 🔧 修复 genLocal 图片 ID 错误
- 🔧 修复按钮点击中间不响应
- 🔧 修复 LoRA 放错目录
- 🔧 修复 insightface 模型路径

### v3.1 — 2026-07-20
- 🔧 修复批量生成按钮点击区域问题

### v3.0 — 2026-07-20
- 🆕 初始版本，多 API 服务商支持
- 🆕 照片上传 + AI 脸型分析 + 发型建议
- 🆕 批量图片生成（3/5/10 张）

---

## 📄 许可

本项目为 Toobey Network Technology Co., Ltd. 内部工具，仅供个人学习使用。

---

*Made by [Toobey521](https://github.com/toobey521)*
