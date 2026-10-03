# 🌟 Cẩm Nang Tài Nguyên Tuyển Chọn Godot 4 (Awesome Godot Hub)

<div align="center">

![Godot 4.3+](https://img.shields.io/badge/Godot-4.3+-478CBF?style=for-the-badge&logo=godotengine&logoColor=white)
![Awesome](https://img.shields.io/badge/Awesome-Curated%20Directory-fc60a8?style=for-the-badge)
![License](https://img.shields.io/badge/License-CC0%20%2F%20MIT-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Masterclass-success?style=for-the-badge)

<p align="center">
  <b>Kho tài nguyên tinh hoa gồm các thư viện plugin hàng đầu, giáo trình masterclass, thuật toán toán học làm game, kho shader, kho asset miễn phí CC0 và mã nguồn game mở cho cộng đồng phát triển Godot 4.x & AI coding agents.</b>
</p>

🌐 **Ngôn ngữ:** [English](AWESOME_GODOT.md) • **Tiếng Việt**

</div>

---

## 📑 Mục Lục

1. [🏛️ Tài Liệu Gốc & Engine Core](#️-tài-liệu-gốc--engine-core)
2. [🧩 Top Addons & Frameworks Thực Chiến](#-top-addons--frameworks-thực-chiến)
3. [🎓 Khóa Học & Kênh Học Masterclass](#-khóa-học--kênh-học-masterclass)
4. [📐 Toán Game, Shaders & Thuật Toán Sinh Tự Động](#-toán-game-shaders--thuật-toán-sinh-tự-động)
5. [🎨 Kho Asset 2D/3D & Âm Thanh Miễn Phí (CC0)](#-kho-asset-2d3d--âm-thanh-miễn-phí-cc0)
6. [🕹️ Dự Án Mẫu & Game Mã Nguồn Mở Tiêu Biểu](#️-dự-án-mẫu--game-mã-nguồn-mở-tiêu-biểu)
7. [⚡ Tích Hợp Sẵn Trong Godot Skills Plugin](#-tích-hợp-sẵn-trong-godot-skills-plugin)

---

## 🏛️ Tài Liệu Gốc & Engine Core

| Tài Nguyên | Mô Tả | Phù Hợp Cho | Liên Kết |
| :--- | :--- | :--- | :--- |
| **Godot 4.x Documentation** | Tài liệu hướng dẫn chính thức, class reference và hướng dẫn từng bước. | Tra cứu API, vòng đời Node, Physics. | [Official Docs](https://docs.godotengine.org/en/stable/) |
| **GDScript 2.0 Reference** | Quy chuẩn static typing, `@annotations`, lambdas và coroutines. | Viết code không warning, tối ưu hiệu năng. | [GDScript Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html) |
| **Godot Shading Reference** | Hướng dẫn viết shader `canvas_item`, `spatial` và `particles`. | Lập trình vật liệu và hiệu ứng hình ảnh 2D/3D. | [Shading Manual](https://docs.godotengine.org/en/stable/tutorials/shaders/index.html) |
| **Godot Engine C++ Source** | Toàn bộ mã nguồn C++ của Godot Engine trên GitHub. | Đọc hiểu cách engine vận hành, phát triển GDExtension. | [GitHub Repository](https://github.com/godotengine/godot) |
| **Godot Improvement Proposals (GIP)** | Các đề xuất và thảo luận kiến trúc tính năng mới của engine. | Nắm bắt lộ trình phát triển của Godot trong tương lai. | [GIP Repo](https://github.com/godotengine/godot-proposals) |

---

## 🧩 Top Addons & Frameworks Thực Chiến

### 🎥 Camera & Điện Ảnh (Cinematics)
- **[Phantom Camera](https://github.com/ramok/phantom-camera)**: Hệ thống điều khiển Camera 2D/3D lấy cảm hứng từ Cinemachine (Unity). Hỗ trợ chuyển cảnh mượt mà, deadzone, bám nhiều mục tiêu, rung chấn camera (screen shake trauma).

### 💬 Hệ Thống Hội Thoại & Cốt Truyện (Narrative)
- **[Dialogic 2.0](https://github.com/dialogic-godot/dialogic)**: Hệ thống hội thoại phân nhánh số 1 cho Godot 4. Cung cấp Timeline trực quan, quản lý nhân vật, biểu cảm chân dung, âm thanh và biến số nhiệm vụ.

### 🧠 Trí Tuệ Nhân Tạo & State Machines (AI)
- **[Beehave](https://github.com/bitwes/beehave)**: Framework Behavior Tree trực quan cho Godot 4. Hỗ trợ Composites, Decorators, Leaves và bộ nhớ chia sẻ Blackboard.
- **[LimboAI](https://github.com/limbonaut/limboai)**: Addon Behavior Tree & HSM viết bằng C++ GDExtension cho hiệu năng tối đa kèm công cụ debug thời gian thực trong editor.

### ⚡ Động Cơ Vật Lý Nâng Cao (Physics Alternatives)
- **[Godot Jolt](https://github.com/godot-jolt/godot-jolt)**: Thay thế hoàn toàn động cơ vật lý 3D mặc định bằng Jolt Physics đa luồng. Tăng tốc độ từ 5x đến 10x cho các va chạm phức tạp và ragdoll.
- **[Godot Rapier 2D/3D](https://github.com/appsinacup/godot-rapier-2d)**: Động cơ vật lý 2D/3D chính xác tuyệt đối (deterministic) viết bằng Rust Rapier, tối ưu cho multiplayer rollback netcode.

### 🌍 Địa Hình & Sinh Thế Giới (Terrain & PCG)
- **[Terrain3D](https://github.com/TokisanGames/Terrain3D)**: Hệ thống địa hình 3D GPU-sculpted tốc độ cao cho Godot 4. Hỗ trợ multi-texturing, cọ vẽ cây cỏ và bản đồ thế giới mở rộng lớn.
- **[ProtonGraph](https://github.com/protongraph/protongraph)**: Công cụ sinh thế giới 3D thủ tục bằng đồ thị node (node-based procedural generation).

### 🌐 Multiplayer & Nền Tảng Game
- **[Netfox](https://github.com/foxssake/netfox)**: Bộ công cụ mạng multiplayer hỗ trợ Client-Side Prediction, Server Reconciliation, Nội suy (Interpolation) và Rollback.
- **[GodotSteam](https://github.com/GodotSteam/GodotSteam)**: Tích hợp đầy đủ Steamworks API (Thành tựu Steam Achievements, Bảng xếp hạng, Cloud Saves, Lobby, P2P).

### 🧪 Kiểm Thử Tự Động (TDD / Testing)
- **[GUT (Godot Unit Testing)](https://github.com/bitwes/Gut)**: Framework kiểm thử tự động tiêu chuẩn cho Godot 4, hỗ trợ bắt tín hiệu Signal assertions và chạy headless qua CLI.

---

## 🎓 Khóa Học & Kênh Học Masterclass

| Kênh / Tác Giả | Nội Dung Nổi Bật | Tại Sao Nên Học | Liên Kết |
| :--- | :--- | :--- | :--- |
| **GDQuest** | Kiến trúc Clean Code, Interactive GDScript Tour, 2D/3D Mechanics | Tiêu chuẩn vàng về cấu trúc code chuyên nghiệp và mã nguồn mở. | [GDQuest Website](https://www.gdquest.com/) |
| **Clear Code** | Các khóa học Godot 4 trọn gói từ 8-12 tiếng (2D, 3D, GDScript) | Hướng dẫn chi tiết từ căn bản đến hoàn thiện full game có hệ thống. | [YouTube Channel](https://www.youtube.com/@ClearCode) |
| **KidsCanCode (Godot Recipes)** | Toán làm game, Context Steering, Grid Movement, Hang động thủ tục | Các công thức (recipes) ngắn gọn, áp dụng ngay thuật toán vào code. | [Godot Recipes](https://kidscancode.org/godot_recipes/4.x/) |
| **HeartBeast** | Pixel Art ARPGs, State Machines, Cảm giác vật lý Platformer | Tối ưu độ mượt, game feel, nhịp animation và juice trong gameplay. | [YouTube Channel](https://www.youtube.com/@uheartbeast) |
| **PlayWithFurcifer** | Tips tối ưu GDScript, Design Patterns thực tế | Kinh nghiệm thực chiến từ các tựa game thương mại đã phát hành. | [YouTube Channel](https://www.youtube.com/@PlayWithFurcifer) |
| **FinePointCGI** | C++, C#, GDExtension, Shaders, Phân tích Network | Nghiên cứu kỹ thuật chuyên sâu về engine và module native. | [YouTube Channel](https://www.youtube.com/@FinePointCGI) |
| **Game Programming Patterns** | Command, Observer, State, Bytecode, Spatial Partitioning | Cuốn sách kinh điển của Robert Nystrom về mẫu thiết kế trong game. | [Đọc Sách Miễn Phí](https://gameprogrammingpatterns.com/) |

---

## 📐 Toán Game, Shaders & Thuật Toán Sinh Tự Động

### 🎨 Thư Viện Shader & Lý Thuyết Shading
- **[GodotShaders.com](https://godotshaders.com/)**: Kho lưu trữ hơn 1,000+ shader 2D/3D miễn phí (Nước Stylized, Viền Pixel Outline, Tan biến Dissolve, Cel Shading, Hậu kỳ Post-Processing).
- **[The Book of Shaders](https://thebookofshaders.com/)**: Giáo trình trực quan từng bước về GLSL fragment shaders, hàm nhiễu Noise và hoa văn sinh tự động.
- **[Inigo Quilez Graphics Math](https://iquilezles.org/)**: Kho kiến thức đỉnh cao về Signed Distance Fields (2D/3D SDFs), toán chiếu sáng Raymarching và hàm đường cong đồ họa.

### 🧮 Toán Học Làm Game & Thuật Toán Bản Đồ
- **[Red Blob Games](https://www.redblobgames.com/)**: Trang hướng dẫn trực quan xuất sắc nhất thế giới về Lưới Lục Giác (Hex Grids), Tìm đường A*, Tạo địa hình ngẫu nhiên và Tầm nhìn Line of Sight.
- **[Catlike Coding](https://catlikecoding.com/)**: Các bài viết toán học chuyên sâu về đường cong Bezier, sinh Mesh thủ tục, Ma trận và Flow Fields.

---

## 🎨 Kho Asset 2D/3D & Âm Thanh Miễn Phí (CC0)

| Nguồn Asset | Thể Loại | Bản Quyền | Liên Kết |
| :--- | :--- | :--- | :--- |
| **Kenney.nl** | 50,000+ Sprite 2D, Model 3D Low-Poly, Giao diện UI, Âm thanh SFX | **CC0 Public Domain** (100% Miễn phí thương mại) | [Kenney Website](https://kenney.nl/) |
| **OpenGameArt.org** | Sprite 2D, Model 3D, Nhạc nền Orchestral, Sound FX | Mã nguồn mở (CC-BY / CC0 / GPL) | [OpenGameArt](https://opengameart.org/) |
| **Freesound.org** | 500,000+ Hiệu ứng Foley, Môi trường Ambient, Âm thanh vũ khí | Creative Commons | [Freesound](https://freesound.org/) |
| **Sonniss GDC Audio Archive** | 100+ GB âm thanh game thương mại cao cấp phát hành hàng năm tại GDC | **Royalty-Free Commercial** | [Sonniss GDC](https://sonniss.com/gameaudioarchive) |
| **Lospec** | Bảng màu Pixel Art (PICO-8, GameBoy, ENDESGA 32) & công cụ Voxel | Cộng đồng miễn phí | [Lospec](https://lospec.com/) |
| **Mixamo** | Nhân vật 3D đã gắn xương (rigged) & hàng ngàn animation mocap | Miễn phí thương mại (Adobe) | [Mixamo](https://www.mixamo.com/) |

---

## 🕹️ Dự Án Mẫu & Game Mã Nguồn Mở Tiêu Biểu

- **[Godot Demo Projects](https://github.com/godotengine/godot-demo-projects)**: Hàng trăm dự án mẫu chính thức của Godot 4 bao gồm 2D, 3D, Audio, Shaders, Vật lý và Navigation.
- **[Pixelorama](https://github.com/Orama-Interactive/Pixelorama)**: Phần mềm vẽ Pixel Art và animation chuyên nghiệp viết 100% bằng Godot Engine.
- **[Tuxemon](https://github.com/Tuxemon/Tuxemon)**: Game nhập vai bắt quái vật theo lượt mã nguồn mở.
- **[Thrive](https://github.com/Revolutionary-Games/Thrive)**: Game mô phỏng tiến hóa quy mô lớn phát triển bằng Godot và C#.

---

## ⚡ Tích Hợp Sẵn Trong Godot Skills Plugin

Toàn bộ tài nguyên chọn lọc ở trên đã được **tích hợp trực tiếp vào Tab "🌟 Godot Awesome" trong Godot Editor**:

1. Mở Godot Editor đã kích hoạt plugin `godot_skills`.
2. Chuyển sang tab **"🌟 Godot Awesome"** tại dock bên phải.
3. Bạn có thể:
   - **Lọc theo danh mục** (Addons, Tutorials, Shaders, Math, Free Assets).
   - **Tìm kiếm tức thì theo từ khóa** (ví dụ: `jolt`, `terrain`, `kenney`, `dialogic`, `math`).
   - Bấm **`🌐 Open in Browser`** để mở ngay trang web trên trình duyệt máy tính.
   - Bấm **`📋 Copy Link`** để sao chép đường link vào clipboard.
   - Bấm **`💡 Ask AI Prompt`** để copy câu lệnh prompt mẫu dán vào trợ lý AI (Antigravity, Cursor, Claude Code) nhằm nhận hướng dẫn tích hợp thư viện đó vào dự án của bạn!
