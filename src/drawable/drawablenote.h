/** @file drawablenote.h
 * 
 * Copyright (c) 2006, Matevž Jekovec, Canorus development team
 * All Rights Reserved. See AUTHORS for a complete list of authors.
 * 
 * Licensed under the GNU GENERAL PUBLIC LICENSE. See COPYING for details.
 */

#ifndef DRAWABLENOTE_H_
#define DRAWABLENOTE_H_

#include "drawablemuselement.h"

class CANote;

class CADrawableNote : public CADrawableMusElement {
	public:
		/**
		 * Y coordinate represents the center of the note!
		 */
		CADrawableNote(CANote *note, CADrawableContext *drawableContext, int x, int y, bool shadowNote = false);
		
		~CADrawableNote();
		
		void draw(QPainter *p, CADrawSettings s);
		
		inline CANote* note() { return (CANote*)_musElement; }
		
		CADrawableNote *clone();
		
		void setDrawLedgerLines(bool ledgerLines) { _drawLedgerLines = ledgerLines; }
		bool drawLedgerLines() { return _drawLedgerLines; }
		void setXPos(int xPos);
		void setYPos(int yPos);
		void setDrawableContext(CADrawableContext *c) { _drawableContext = c; }
		
	private:
		bool _drawLedgerLines;
		bool _shadowNote;	///Is the current note shadow note?
};

#endif /*DRAWABLENOTE_H_*/