
Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)

	Если ВидНоменклатуры <> Перечисления.ВидНоменклатуры.ПосещениеАттракциона Тогда
		НомерУдаляемого = ПроверяемыеРеквизиты.Найти("КоличествоПосещений");
		Если НомерУдаляемого <> Неопределено Тогда
			ПроверяемыеРеквизиты.Удалить(НомерУдаляемого);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры
