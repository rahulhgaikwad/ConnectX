BUG REPORT

==================================================================================

Developer Name : Rahul Gaikwad

==================================================================================

Bugs found in below functions: 
1. bool inBounds(int, int)
2. void at(int)

==================================================================================

Details : There is a logical bug in inBounds() function due to which at() function 
misbehaves.

==================================================================================

Explaination : There is bug in inBounds() function due to which at() function is 
behaving weird and showing abnormal results. In function inBounds() there are two 
'if' conditions. 

First if condition is as follows:

if( w>=width || w<0 ) {    //line 47 in ConnectX.cpp
	inside = false;
} else {
	inside = true;
}

First 'if' condition is checking for width greater than boards width or width less 
than zero. If condition saticefies then it assigns 'false' to boolean 'inside'. If 
condition fails then just assign 'true' to boolean 'inside'

Second if condition is as follows:

if( h<0 || h>=height ) {    //line 52 in ConnectX.cpp
	inside = false;
} else {
	inside = true;
}

Second 'if' condition is checking for height greater than boards height or height 
less than zero. If condition saticefies then it assigns 'false' to boolean 'inside'. 
If condition fails then assign 'true' to boolean 'inside'. 

return inside;    //line 57 in ConnectX.cpp

On last line of inBounds() function returns a boolean 'inside'.

The problem arises, if one of the 'if' condition fails and other 'if' condition 
saticefies; then boolean 'inside' holds an ultimate value at the end of function 
which all depends on if(h<0 || h>=height) condition.

The condition if(w>=width || w<0) whether or not be 'true' or 'false', the value
of boolean 'inside' will always depends on condition if(h<0 || h>=height).

==================================================================================
Test Cases:

So for testing purpose, Lets write a test case which brings such a situation.
First test case is as follows:

TEST(ConnectXTest, testWidthOutBoundsFalse)  //line 176 in ConnectXTest.cpp
{
	ConnectX obj;
	ASSERT_EQ(obj.at(50,1),-1);
}

In above 'testWidthOutBoundsFalse' test case, we have created an object 'obj' of 
ConnectX class. It sets default dimentions of board as width = 7, height = 6 and 
to_win = 4. Following code asserts equality:

ASSERT_EQ(obj.at(50,1),-1);  //line 179 in ConnectXTest.cpp

Now, assert equality in between values -1 and a value returned by at(50,1) function. 
obj.at(50,1) returns a value '0' which is 'EMPTY' space on board, but actually 
obj.at(50,1) should return '-1' which is 'INVALID' space on board as we are passing 
'50' as a width, which is greater than boards width of '7'. The above test case 
ultimately fails which shows at() function behaved abnormally due to bug in 
inBounds() function.

Let's create one more test to confirm our conclusion.
Second test case is as follows:

TEST(ConnectXTest, testWidthOutBoundsTrue)  //line 206 in ConnectXTest.cpp
{
	ConnectX obj;
	ASSERT_EQ(obj.at(50,1),0);
}

In above 'testWidthOutBoundsTrue' test case we have created an object 'obj' of 
ConnectX class. It sets default dimentions of board as width = 7, height = 6 and 
to_win = 4. Following code asserts equality:

ASSERT_EQ(obj.at(50,1),0);  // line 209 in ConnectXTest.cpp

Now, assert equality in between values 0 and a value returned by at((50,1) function. 
obj.at(50,1) returns a value '0' which is 'EMPTY' space on board, but actually 
obj.at(50,1) should return '-1' which is 'INVALID' space on board, as we are passing 
'50' as a width, which is greater than boards width of '7'. The above test case will 
pass. It shows that, eventhough there is 'INVALID' space; at() function is returning 
a 'EMPTY' space. This proves that at() function is misbehaving due to bug in 
inBounds() function.