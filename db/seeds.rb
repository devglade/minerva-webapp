user_1 = User.create(email: 'neoswirl@gmail.com', password: 'password', name: '노현종')
user_2 = User.create(email: 'wndus85@gmail.com', password: 'password', name: '송주연')
#
retrospect = Retrospect.create title: '데브글레이드 회고', description: 'RetroSpin 개발 회고', user_id: user_1.id
spin = Spin.create status: 1, title: '1차개발 회고', summary: '처음으로 해본 프로젝트에 대해 회고해봅시다.', retrospect_id: retrospect.id, user_id: user_1.id
post = Post.create content: '1차 개발이 완료되었습니다. 좋구만유.', user_id: user_1.id, spin_id: spin.id
post = Post.create content: '서버개발 재밌었어욤..', user_id: user_2.id, spin_id: spin.id