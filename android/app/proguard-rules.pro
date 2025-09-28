    # Keep Razorpay related classes and annotations
    -keepattributes *Annotation*
    -dontwarn com.razorpay.**
    -keep class com.razorpay.** {*;}
    -optimizations !method/inlining/
    -keepclasseswithmembers class * { public void onPayment*(... ); }

    # Prevent R8 from failing on the missing ProGuard annotations
    -dontwarn proguard.annotation.**