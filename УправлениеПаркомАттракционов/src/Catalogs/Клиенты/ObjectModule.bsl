

//@skip-check module-accessibility-at-client
//@skip-check module-structure-method-in-regions
Процедура ПриЗаписи(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;	
	
	Телефон = НомерТелефонаКлиентСервер.НормализированныйНомерТелефона(Телефон, Истина);
	
КонецПроцедуры
