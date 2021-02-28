#!/bin/sh
PEDNIENTES="$(task status:pending count)"
PASADAS="$(task +OVERDUE count)"
PARA_HOY="$(task due:today status:pending count)"
ESCUELA="$(task +Escuela status:pending count)"
TRAMITES="$(task +Tramites status:pending count)"
PROXIMAS="$(task due:tomorrow status:pending count)"
ETIQUETA=""

if [ $PASADAS -gt 0 ]
then
	ETIQUETA="$ETIQUETA !$PASADAS/"
fi
if [ $ESCUELA -gt 0 ]
then
	ETIQUETA="$ETIQUETA  $ESCUELA/"
fi
if [ $TRAMITES -gt 0 ]
then
	ETIQUETA="$ETIQUETA  $TRAMITES/"
fi
if [ $PARA_HOY -gt 0 ]
then
	ETIQUETA="$ETIQUETA  $PARA_HOY/"
fi
if [ $PROXIMAS -gt 0 ]
then
	ETIQUETA="$ETIQUETA + $PROXIMAS/"
fi

ETIQUETA="$ETIQUETA  $PEDNIENTES"

echo -e $ETIQUETA
