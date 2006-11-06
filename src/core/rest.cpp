/** @file core/rest.cpp
 * 
 * Copyright (c) 2006, Matevž Jekovec, Canorus development team
 * All Rights Reserved. See AUTHORS for a complete list of authors.
 * 
 * Licensed under the GNU GENERAL PUBLIC LICENSE. See COPYING for details.
 */

#include "core/rest.h"
#include "core/staff.h"

CARest::CARest(CARestType type, CAPlayableLength length, CAVoice *voice, int timeStart, int dotted) 
 : CAPlayable(length, voice, timeStart, dotted) {
 	_musElementType = CAMusElement::Rest;
 	_restType = type;
}

CARest::~CARest() {
}

CARest *CARest::clone() {
	return new CARest(_restType, _playableLength, _voice, _timeStart, _dotted);
}

const QString CARest::restTypeML() {
	switch (_restType) {
		case Normal:
			return "r";
			break;
		case Hidden:
			return "s";
			break;
	}
}

const QString CARest::lengthML() {
	QString length;
	switch (_playableLength) {
		case CAPlayable::Breve:
			length = "0";
			break;
		case CAPlayable::Whole:
			length = "1";
			break;
		case CAPlayable::Half:
			length = "2";
			break;
		case CAPlayable::Quarter:
			length = "4";
			break;
		case CAPlayable::Eighth:
			length = "8";
			break;
		case CAPlayable::Sixteenth:
			length = "16";
			break;
		case CAPlayable::ThirtySecond:
			length = "32";
			break;
		case CAPlayable::SixtyFourth:
			length = "64";
			break;
		case CAPlayable::HundredTwentyEighth:
			length = "128";
			break;
	}
	
	return length;
}

int CARest::compare(CAMusElement *elt) {
	if (elt->musElementType()!=CAMusElement::Rest)
		return -1;
	
	int diffs=0;
	if (_playableLength!=((CAPlayable*)elt)->playableLength()) diffs++;
	if (timeLength()!=((CAPlayable*)elt)->timeLength()) diffs++;
	
	return diffs;
}