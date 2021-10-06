# CustomerVoice
<br>

1. 개요 <br>
사용자가 상품들에 대한 리뷰를 작성하고, 기업에서 제품별 시장의 반응을 한눈에 볼 수 있는 B2C 채널 Application입니다. <br>
swift, swiftUI, cloudKit 기반으로 작성된 ios Application입니다.<br><br>

2. 주요 UI

Main UI<br>
<img src = "https://user-images.githubusercontent.com/12101752/134774823-31b63fb1-e177-4cc8-8a6f-b5e195639c3c.PNG" width="30%" height="30%"><br><br>
제품 상세 페이지 : <br>
	Main화면에서 개별 상품 클릭 시 발생하는 화면입니다.<br>
<img src = "https://user-images.githubusercontent.com/12101752/134774826-9c75be53-83d7-426b-98b5-694e5eb14627.PNG" width="30%" height="30%"><br><br>
리뷰 작성 페이지 : <br>
	사용자가 새로운 리뷰를 등록할 수 있습니다. <br>
	제품 상세 페이지에서 + 버튼 클릭시 발생하는 화면입니다.<br>
<img src = "https://user-images.githubusercontent.com/12101752/134774832-5d15a669-e687-4816-9bf2-d5480d42b98d.PNG" width="30%" height="30%"><br><br>
리뷰 상세 페이지 : <br>
	제품 상세 페이지에서 개별 리뷰 클릭시 발생하는 화면입니다. <br>
	해당 페이지에서 사용자는 해당 리뷰에 대한 삭제가 가능합니다.(편집 기능은 구현예정)<br>
<img src = "https://user-images.githubusercontent.com/12101752/134774829-fcc4aa4d-17a3-4575-beba-9c333a7e96f6.PNG" width="30%" height="30%"><br><br>


3. 추가 개선 과제 <br>
- 회원 가입 및 회원관리기능 추가 필요
- 리뷰 삭제/편집 시 권한이 있는 회원만 가능하도록 수정 필요
- Main 화면에서 제품 카테고리별로 필터 기능 추가 및 제품명/모델명으로 검색 기능 추가 필요
- 퍼포먼스 및 안정성 개선 필요
- 관리자 계정의 경우 제품 추가/수정/삭제가 가능하도록 구현 필요

<br>

4. Reference <br>
- https://github.com/rebeloper/SwiftUICloudKit
