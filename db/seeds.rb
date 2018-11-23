user_1 = User.create(email: 'neoswirl@gmail.com', password: 'password', name: '노현종', confirmed_at: Time.now)
user_2 = User.create(email: 'wndus85@gmail.com', password: 'password', name: '송주연', confirmed_at: Time.now)

space = Space.create name: '데브글레이드', url: 'devglade', description: '회고를 중요시하는 팀입니다.', is_public: true, user_id: user_2.id
space = Space.create name: '구글', url: 'google', description: '세계최고 검색사이트를 만드는 회사', is_public: true, user_id: user_2.id
space = Space.create name: '페이스북', url: 'facebook', is_public: true, user_id: user_2.id
space = Space.create name: '내 공간', url: 'my', is_public: false, user_id: user_2.id
project = Project.create title: '데브글레이드 회고', description: 'RetroSpin 개발 회고', user_id: user_1.id, space_id: space.id
project = Project.create title: '나만의 회고', description: 'RetroSpin 개발 회고', user_id: user_2.id, space_id: space.id

spin = Spin.create status: 1, title: '1차개발 회고', summary: '처음으로 해본 프로젝트에 대해 회고해봅시다.', project_id: project.id, user_id: user_1.id
section = Section.create title: '좋았던 점', position: 1, spin_id: spin.id
Section.create title: '안좋았던 점', position: 2, spin_id: spin.id
Section.create title: '개선했으면 하는 것', position: 3, spin_id: spin.id
post = Post.create content: '1차 개발이 완료되었습니다. 좋구만유.', user_id: user_1.id, spin_id: spin.id, section_id: section.id, position: 2
post = Post.create content: '서버개발 재밌었어욤..', user_id: user_2.id, spin_id: spin.id, section_id: section.id, position: 1