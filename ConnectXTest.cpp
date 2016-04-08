/**
 * Unit Tests for ConnectX class
**/

#include <gtest/gtest.h>
#include <iostream>
#include "ConnectX.h"
 
class ConnectXTest : public ::testing::Test
{
	protected:
		ConnectXTest(){}
		virtual ~ConnectXTest(){}
		virtual void SetUp(){}
		virtual void TearDown(){}
};

TEST(ConnectXTest, sanityCheck)
{
	ASSERT_TRUE(true);
}

TEST(ConnectXTest, checkBlackTurn)
{
	ConnectX obj;
	obj.showBoard();
	ASSERT_EQ(obj.whoseTurn(),2);
}

TEST(ConnectXTest, checkWhiteTurn)
{
	ConnectX obj;
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	ASSERT_EQ(obj.whoseTurn(),1);
}

TEST(ConnectXTest, checkNotWhiteTurn)
{
	ConnectX obj;
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	ASSERT_EQ(obj.whoseTurn(),2);
}

TEST(ConnectXTest, checkPlacePieceBelowZero)
{
	ConnectX obj;
	obj.placePiece(-1);
	obj.showBoard();
	ASSERT_EQ(obj.whoseTurn(),1);
}

TEST(ConnectXTest, checkPlacePieceAboveWidth)
{
	ConnectX obj(3,3,4);
	obj.placePiece(3);
	obj.placePiece(3);
	obj.placePiece(3);
	obj.placePiece(3);
	obj.showBoard();
	ASSERT_EQ(obj.whoseTurn(),2);
}

TEST(ConnectXTest, checkHeight)
{
	ConnectX obj;
	obj.showBoard();
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	obj.placePiece(0);
	obj.showBoard();
	obj.placePiece(9);
	obj.placePiece(-5);
	obj.placePiece(0);
	obj.showBoard();
	ASSERT_EQ(obj.whoseTurn(),2);
}