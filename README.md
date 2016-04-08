Name : Rahul Gaikwad

Bug : There is bug in inBounds() function due to which at() function misbehaves. 

Explaination : There is bug in inBounds() function due to which at() function is behaving weird and showing abnormal results.
In function inBounds() there are two 'if' conditions. 

First if condition is as follows:
if( w>=width || w<0 ) {
		inside = false;
} else {
		inside = true;
}
First 'if' condition is checking for width greater than boards width or width less than zero. If condition saticefies then assign 'false' to boolean 'inside'. If condition fails then just assign 'true' to boolean 'inside'

Second if condition is as follows:
if( h<0 || h>=height ) {
		inside = false;
} else {
		inside = true;
}
Second 'if' condition is checking for height greater than boards height or height less than zero. If condition saticefies then assign 'false' to boolean 'inside'. If condition fails then assign 'true' to boolean 'inside'. 

return inside;
On last line of inBounds() we are returning boolean 'inside'.

The problem arises, if one of the 'if' condition fails and other 'if' condition saticefies; then boolean 'inside' holds an ultimate value at the end of function which all depends on 
if(h<0 || h>=height).

The condition if(w>=width || w<0) whether or not 'true' or 'false' 
the boolean 'inside' value will always depends on  condition if(h<0 || h>=height).


So for testing purpose, Lets write a test case which brings such a situation.

TEST(ConnectXTest, testMakeBugFail)
{
	ConnectX obj;
	ASSERT_EQ(obj.at(100,1),-1);
}

In above 'testMakeBugFail' test case we have created object 'obj' of ConnectX class. It sets default dimentions for board as width = 7, height = 6 and to_win = 4. 
Below code asserts equality:

ASSERT_EQ(obj.at(100,1),-1);

Now, assert equality in between values -1 and a value returned by at() function. obj.at(100,1) returns a value '0' which is 'EMPTY' space on board but actually obj.at(100,1) should return '-1' which is 'INVALID' space on board as we are passing '100' as a width which is greater than boards width of '7'. 
The above test case ultimately fails which shows at() function behaved abnormally due to bug in inBounds() function.


Let's create one more test to confirm our conclusion.

TEST(ConnectXTest, testMakeBugFailPass)
{
	ConnectX obj;
	ASSERT_EQ(obj.at(100,1),0);
}

In above 'testMakeBugFailPass' test case we have created object 'obj' of ConnectX class. It sets default dimentions for board as width = 7, height = 6 and to_win = 4. 
Below code asserts equality:

ASSERT_EQ(obj.at(100,1),0);

Now, assert equality in between values 0 and a value returned by at() function. obj.at(100,1) returns a value '0' which is 'EMPTY' space on board but actually obj.at(100,1) should return '-1' which is 'INVALID' space on board as we are passing '100' as a width which is greater than boards width of '7'. 
The above test case will pass. It shows that eventhough there is 'INVALID' space; at() function is returning a 'EMPTY' space. 
This proves that at() function is misbehaving due to bug in inBounds().