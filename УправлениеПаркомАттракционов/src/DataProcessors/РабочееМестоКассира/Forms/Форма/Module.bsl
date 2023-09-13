
//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ПозицииПродажиПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)

	СтандартнаяОбработка = Ложь;	

КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура Подбор(Команда)

	Элементы.СписокНоменклатуры.Видимость = НЕ Элементы.СписокНоменклатуры.Видимость;
	Элементы.ПозицииПродажиПодбор.Пометка = Элементы.СписокНоменклатуры.Видимость;

КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура СписокНоменклатурыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДанныеСтроки = Элемент.ТекущиеДанные;
	
	Если ДанныеСтроки.ЭтоГруппа Тогда
		Возврат;		
	КонецЕсли;
			
	ДобавитьУникальнуюПозицию(ВыбраннаяСтрока, ДанныеСтроки.Цена);
	 
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура СписокНоменклатурыНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	ДанныеСтроки = Элемент.ТекущиеДанные;
	
	Если ДанныеСтроки.ЭтоГруппа Тогда
		Выполнение = Ложь;
		Возврат;
	КонецЕсли;
	
	Значение = Новый Структура;
	Значение.Вставить("Номенклатура", ДанныеСтроки.Номенклатура);
	Значение.Вставить("Цена", ДанныеСтроки.Цена);
	
	ПараметрыПеретаскивания.Значение = Значение;
		
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ПозицииПродажиПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	
	Значение = ПараметрыПеретаскивания.Значение;
	
	Если ТипЗнч(Значение) <> Тип("Структура") Тогда
		Возврат;	
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
		
	ДобавитьУникальнуюПозицию(Значение.Номенклатура, Значение.Цена);

КонецПроцедуры

//@skip-check module-structure-method-in-regions
//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ДобавитьУникальнуюПозицию(Номенклатура, Цена)
	
	 Фильтр = Новый Структура;
	 Фильтр.Вставить("Номенклатура", Номенклатура);
	 
	 НайденныеСтроки = ПозицииПродажи.НайтиСтроки(Фильтр);
	 
	 Если НайденныеСтроки.Количество() > 0 Тогда
	 	Возврат;	 	
	 КонецЕсли;
	 
	 Строка = ПозицииПродажи.Добавить();
	 Строка.Номенклатура = Номенклатура;
	 Строка.Цена = Цена;
	 Строка.Количество = 1;
	 Строка.Сумма = Цена;
	 
	 РассчитатьСуммуДокумента();
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ПозицииПродажиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();	

КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ПозицииПродажиЦенаПриИзменении(Элемент)
	
	ДанныеСтроки = Элементы.ПозицииПродажи.ТекущиеДанные;
	РассчитатьСуммуТЧ(ДанныеСтроки);
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ПозицииПродажиКоличествоПриИзменении(Элемент)
	
	ДанныеСтроки = Элементы.ПозицииПродажи.ТекущиеДанные;
	РассчитатьСуммуТЧ(ДанныеСтроки);	

КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура РассчитатьСуммуТЧ(СтрокаТЧ)
	
	СтрокаТЧ = Элементы.ПозицииПродажи.ТекущиеДанные;
	СтрокаТЧ.Сумма = СтрокаТЧ.Цена * СтрокаТЧ.Количество;
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ЗаписатьПродажу(Команда)
	
	НовыйДокумент = ЗаписатьПродажуНаСервере();
	
	ОповеститьОбИзменении(НовыйДокумент);
	
	ПоказатьОповещениеПользователя("Создан документ", 
	ПолучитьНавигационнуюСсылку(НовыйДокумент), Строка(НовыйДокумент));
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура БаллыКСписаниюПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента();	

КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ПозицииПродажиНоменклатураПриИзменении(Элемент)
	
	ДанныеСтроки = Элементы.ПозицииПродажи.ТекущиеДанные;
	ДанныеСтроки.Цена = ПолучитьЦенуНоменклатуры(ДанныеСтроки.Номенклатура);
	
	РассчитатьСуммуТЧ(ДанныеСтроки);
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	СуммаИтого = ПозицииПродажи.Итог("Сумма") - БаллыКСписанию;
	ЗаполнитьДекорациюБаллыКлиента();
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура ДекорацияБаллыКлиентаОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)

	Если СтрНачинаетсяС(НавигационнаяСсылкаФорматированнойСтроки, "#Заполнить_") Тогда
		СтандартнаяОбработка = Ложь;
		БаллыКСписанию = Число(СтрЗаменить(НавигационнаяСсылкаФорматированнойСтроки, "#Заполнить_", ""));
		
					
	КонецЕсли;	

КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере
Функция ПолучитьЦенуНоменклатуры(Номенклатура)
	
	Возврат РегистрыСведений.ЦеныНоменклатуры.ЦенаНоменклатуры(Номенклатура, ТекущаяДатаСеанса());
	
КонецФункции

//@skip-check module-structure-method-in-regions
&НаСервере
Функция ЗаписатьПродажуНаСервере()

	
	ДокОбъект = Документы.ПродажаБилетов.СоздатьДокумент();
	
	ДокОбъект.Заполнить(Неопределено);
	
	
	ДокОбъект.Дата = ТекущаяДатаСеанса();
	ДокОбъект.Клиент = Клиент;
	ДокОбъект.ПозицииПродажи.Загрузить(ПозицииПродажи.Выгрузить());
	ДокОбъект.БаллыКСписанию = БаллыКСписанию;
	ДокОбъект.СуммаДокумента = СуммаИтого - БаллыКСписанию;
	
	Если НЕ ДокОбъект.ПроверитьЗаполнение() Тогда
		ВызватьИсключение "Не удалось записать продажу!";		
	КонецЕсли;
	
	ДокОбъект.Записать(РежимЗаписиДокумента.Проведение);
	
	СброситьЗаполнениеФормы();
	
	Возврат ДокОбъект.Ссылка;
		
КонецФункции



//@skip-check module-structure-method-in-regions
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Элементы.СписокНоменклатуры.Видимость = Ложь;	
	Элементы.ДекорацияБаллыКлиента.Видимость = Ложь;
	
	СоздатьДекорацииИзбранныхТоваров();	
	
	ЗаполнитьИзбранныеТоварыКлиента();
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере
Процедура СоздатьДекорацииИзбранныхТоваров()
		
	КоличествоИзбранныхТоваров = 3;
	
	Для Сч = 1 По КоличествоИзбранныхТоваров Цикл
		ИмяДекорации = "ДекорацияИзбранныхТоваров_" + XMLСтрока(Сч);
		
		Декорация = Элементы.Добавить(ИмяДекорации ,Тип("ДекорацияФормы"), Элементы.ГруппаПопулярныеПокупки);
		Декорация.Вид = ВидДекорацииФормы.Надпись;
		Декорация.Видимость = Ложь;
		Декорация.Гиперссылка = Истина;
		Декорация.УстановитьДействие("Нажатие", "Подключаемый_ДекорацияИзбранныхТоваровНажатие");
		
		
		СтрокаОписанияДекорации = ДинамическиеЭлементы.Добавить();
		СтрокаОписанияДекорации.ИмяЭлемента = ИмяДекорации;
		
	КонецЦикла;
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура КлиентПриИзменении(Элемент)
	
	КлиентПриИзмененииНаСервере();	

КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере
Процедура КлиентПриИзмененииНаСервере()
	
	ЗаполнитьДекорациюБаллыКлиента();
	
	ЗаполнитьИзбранныеТоварыКлиента();
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере
Процедура ЗаполнитьИзбранныеТоварыКлиента()
	
	СброситьИзбранныеТовары();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 3
		|	ПродажиОбороты.Номенклатура
		|ИЗ
		|	РегистрНакопления.Продажи.Обороты(&НачалоПериода, &КонецПериода,, Клиент = &Клиент) КАК ПродажиОбороты
		|
		|УПОРЯДОЧИТЬ ПО
		|	ПродажиОбороты.СуммаОборот УБЫВ";
	
	Запрос.УстановитьПараметр("НачалоПериода", ДобавитьМесяц(ТекущаяДатаСеанса(), -3));
	Запрос.УстановитьПараметр("КонецПериода", ТекущаяДатаСеанса());
	Запрос.УстановитьПараметр("Клиент", Клиент);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Счч = 0;
	
	Пока Выборка.Следующий() Цикл
		
		ТекущаяСтрока = ДинамическиеЭлементы[Счч];
		ТекущаяСтрока.Активность = Истина;
		ТекущаяСтрока.Номенклатура = Выборка.Номенклатура;
		
		Счч = Счч + 1;
		
	КонецЦикла;
	
	ЗаполнитьДекорацииИзбранныхТоваров();
			
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере
Процедура СброситьИзбранныеТовары()
	
	Для Каждого Строка Из ДинамическиеЭлементы Цикл
		Строка.Активность = Ложь;
		Строка.Номенклатура = Справочники.Номенклатура.ПустаяСсылка();		
	КонецЦикла;
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере
Процедура ЗаполнитьДекорацииИзбранныхТоваров()
	
	
	Для Каждого Строка Из ДинамическиеЭлементы Цикл
		
		Элемент = Элементы[Строка.ИмяЭлемента];
		Элемент.Видимость = Строка.Активность;
		Элемент.Заголовок = Строка.Номенклатура;
		
		
	КонецЦикла;
	
	
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере 
Процедура ЗаполнитьДекорациюБаллыКлиента()
	
	Если НЕ ЗначениеЗаполнено(Клиент) Тогда
		Элементы.ДекорацияБаллыКлиента.Видимость = Ложь;
		Возврат	
	КонецЕсли;
	
	Элементы.ДекорацияБаллыКлиента.Видимость = Истина;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	БонусныеБаллыКлиентовОстатки.СуммаОстаток
		|ИЗ
		|	РегистрНакопления.БонусныеБаллыКлиентов.Остатки(, Клиент = &Клиент) КАК БонусныеБаллыКлиентовОстатки";
	
	Запрос.УстановитьПараметр("Клиент", Клиент);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		ОстатокБаллов = Выборка.СуммаОстаток;
	Иначе
		ОстатокБаллов = 0;	
	КонецЕсли;
	
	Если ОстатокБаллов = 0 Тогда
		Элементы.ДекорацияБаллыКлиента.Заголовок = "У клиента нет начисленных баллов";
		Возврат;		
	КонецЕсли;
	
	МаксимальнаяДоля = Константы.МаксимальнаяДоляОплатыБаллами.Получить();
	МаксимумБалловКСписанию = Мин(ОстатокБаллов, СуммаИтого * МаксимальнаяДоля / 100);
	
	Шаблон = "Накоплено %1 баллов, из них можно списать %2. ";
	Описание = СтрШаблон(Шаблон, ОстатокБаллов, МаксимумБалловКСписанию);
	
	ШаблонСсылки = "#Заполнить_%1";
	СсылкаЗаполненияБаллов = СтрШаблон(ШаблонСсылки, XMLСтрока(МаксимумБалловКСписанию));
	
	
	
	ЧастиФорматированнойСтроки = Новый Массив;
	ЧастиФорматированнойСтроки.Добавить(Описание);
	ЧастиФорматированнойСтроки.Добавить(Новый ФорматированнаяСтрока("Заполнить.", , , , СсылкаЗаполненияБаллов));
	
	Элементы.ДекорацияБаллыКлиента.Заголовок = Новый ФорматированнаяСтрока(ЧастиФорматированнойСтроки);	
		
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаКлиенте
Процедура Подключаемый_ДекорацияИзбранныхТоваровНажатие(Элемент)
	
	ИмяЭлемента = Элемент.Имя;
	
	Фильтр = Новый Структура("ИмяЭлемента", ИмяЭлемента);
	НайденныеСтроки = ДинамическиеЭлементы.НайтиСтроки(Фильтр);
	
	Если НайденныеСтроки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Строка = НайденныеСтроки[0];
	
	Номенклатура = Строка.Номенклатура;
	
	ДобавитьУникальнуюПозицию(Номенклатура, ПолучитьЦенуНоменклатуры(Номенклатура)); 
	
	
КонецПроцедуры

//@skip-check module-structure-method-in-regions
&НаСервере
Процедура СброситьЗаполнениеФормы()
	
	Клиент = Справочники.Клиенты.ПустаяСсылка();
	ПозицииПродажи.Очистить();
	СуммаИтого = 0;
	БаллыКСписанию = 0;
	
	ЗаполнитьДекорациюБаллыКлиента();
	
	ЗаполнитьИзбранныеТоварыКлиента();
	
КонецПроцедуры


