# Changes

*   Movie and Actor, Comment and Cast, I use Integer ids instead of String ids since that is more conventional and supports auto increment
*   Setting any Date, I use a String and in each set(Release)Date(OfBirth) method, I generate a local time from that
*   Setting any foreign key value, I have both a method signature that accepts the object and one that accepts the object's primary key type
*   Reading an individual Cast or Comment, I kept the naming the same as Actor, Movie and User (readCast instead of readCastById)
*   Updating a comment takes a Comment object and not just a comment string
