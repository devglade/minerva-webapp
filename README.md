# Retrospin
## 반복적인 회고를 지향하는 온라인 퍼실르테이터 서비스

# Getting Started

## Prerequisites
### Brew

맥에서 개발환경을 구축하기 위해선 [homebrew](http://brew.sh/)를 설치해야 한다. homebrew는 맥용 SW패키징 시스템으로 각종 오픈소스 프로그램을 쉽게 설치 할 수 있게 해준다.

```shell
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Ruby 
 
맥에는 기본적으로 ruby가 설치되어 있지만, 최신 버전의 ruby를 이용하기 위해선 rbenv, ruby-build를 사용하는 것이 좋다. 프로젝트 별로 다른 버전의 ruby가 사용될 때에도 rbenv를 이용하면 프로젝트에 맞는 ruby version을 지정할 수 있다. 과거에는 rvm을 많이 이용했으나, 최근에는 rbenv가 대세이다. 

* rbenv, ruby-build 모두 brew로 설치하면 된다.

```shell
$ brew install rbenv ruby-build
```

* .bashrc 혹은 .profile 파일에 아래의 내용을 추가한다. 

```shell
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
```

* 위에 설정한 환경 변수가 load 될 수 있게 새 터미널 창을 열고, rbenv 를 통해 최신 버전의 ruby를 설치하고 bundler를 설치한다.

```shell
$ rbenv install -l # 설치 할 수 있는 ruby 버전 확인
$ rbenv install 2.5.1 -k # 가끔 ruby source가 필요한 gem이 있기 때문에
                         # -k 옵션을 줘서 컴파일 후 소스를 삭제하지 않고 남겨둔다.
$ rbenv global 2.5.1 
$ rbenv rehash 
$ gem install bundler
$ 
```

rbenv에서 디렉토리 별로 ruby 버전을 지정하고 싶으면 rbenv global 명령 대신 rbenv local 명령을 사용하면 된다.

`$ rbenv local 2.5.1`

이 명령을 실행하면 명령이 실행된 디렉토리에 해당 버전이 명시된 .ruby-version 생성된다.
`brew search rbenv` 명령으로 다른 plugin도 찾아볼 수 있으니 유용한 것이 있으면 설치하면 된다.

### Postgresql 

Databse로 사용할 postgresql을 설치한다

[Postgresql Mac App](https://www.postgresql.org/download/macosx/)을 다운받거나 brew로 설치를 해도 된다.

```shell
$ brew install postgresql
```

시스템 재부팅 후 자동으로 postgresql을 실행하려면 아래의 명령을 실행해서 launchctl 이 postgresql을 로딩할 수 있게 해 준다. launchctl을 이용하지 않고 수동으로 실행하려면 `$ postgres -D /usr/local/var/postgres` 명령을 이용하면 된다.

```shell
$ ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

### Redis
웹소켓의 adapter 로 Redis를 사용하기때문에 Redis설치가 필요하다.

```shell
$ brew install redis
```
redis를 실행할때는
```shell
$ redis-server
```
하면 redis가 실행된다.

### Webpacker
회고 포스트 작성 화면은 vue.js 를 사용하였는데 개발모드일때는 
```
bin/webpack-dev-server
```
를 실행해 webpack서버를 띄워놓으면 vue수정을 할때마다 자동으로 브라우저 재로딩이 되서 편하다. 

## Project Install

### Checkout

### bundle

github에서 프로젝트 체크아웃을 받았으면 일단 필요한 gem들부터 설치한다. 
```shell
$ bundle install -j8
```

-j 옵션은 동시에 다운로드 받는 잡의 갯수를 지정하는 것이다.

### Database

Postgresql Database를 생성하고, db migration을 한다.

```shell
$ rake db:create
$ RAILS_ENV=test rake db:create
$ rake db:migrate
```

test db의 경우 migration을 할 필요가 없는데, `rake test:db` 명령을 실행하면 테스트 DB에 들어있는 데이터와 테이블을 모두 제거하고, db:migration을 통해 생성된 schema.rb(혹은 structure.sql) 파일을 통해 스키마를 생성하게 된다. 

이렇게 DB 스키마를 만들고 난 후

```shell
$ rake db:seed
```

명령을 통해 초기 데이타를 생성하면 된다.

### Rails server

```shell
$ rails s
```

### Redis Run
```shell
$ redis-server
```

bundle 설치, db 생성이 끝났으면 위의 명령으로 웹 서버와 redis를 띄우고, `http://localhost:3000` 에 접속해서 웹 서버가 문제 없이 떴는지 확인한다. 


