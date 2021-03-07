# README

* Ruby version: 2.7.0p0
* Rails version: 6.0.3.5

Задание реализовано в виде сервиса на Rails, у которого есть API: get-запрос на сервер с указанием id Лицензии через get-параметры<br/>
Пример запроса:
http://0.0.0.0:3000/get-version.xml?id=2<br/>
Сервер присылает ответ в виде xml с доступными версиями<br/>

ID лицензии соответствует id записи в таблице 'Licenses' в Базе данных. При запуске приложения, если в БД пусто, будет автоматически создано две Лицензии, соответствующие лицензиям из примеров. Вот их данные:
* License id = 1:
  - paid_till: '04.11.2020'
  - max_version = nil
  - min_version = nil

* License id = 2:
  - paid_till: '04.11.2020'
  - max_version = '20.06'
  - min_version = '19.05'

Сервис FlussonicLastVersion представлен классом с методом get, который возвращает "рыбу" - версию '21.02' 

Для запуска приложения на новой машине: 
- bundle install
- yarn install --check-files
- rails db:migrate
- rails s
