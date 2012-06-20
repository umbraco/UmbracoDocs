# Sending parameters to base methods

Now that you have your simple base method up and running, let look into how to send parameters to your base method.

I modified the Hello Method from previous example to take two strings as parameters

    namespace BaseTest {
      public class TestClass {
        public static string Hello( string str1, string str2 ) {
            return str1 + " " + str2;
        }
      }
    } 

Now when you want to call the base method you just make a request to the following url:
http://yourdomain.com/Base/TestAlias/Hello/Nice/Test.aspx

The "Nice" and "Test" after the method name is the two parameters that is parsed along to the base call and will result in the output: "Nice Test"!