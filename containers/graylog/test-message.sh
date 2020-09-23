curl -XPOST http://localhost:12201/gelf -p0 -d \
    '{
        "short_message":"Test message", 
        "host":"example.org", 
        "facility":"test", 
        "_foo":"bar"
    }'