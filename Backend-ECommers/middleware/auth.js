const jwt = require('jsonwebtoken');

const authenticateJWT = (req, res, next) => {
    const token = req.header('Authorization')?.replace('Bearer ', '');
    if (!token) {
        return res.status(401).json({ status: 'error', message: 'Access denied' });
    }

    jwt.verify(token, process.env.JWT_SECRET, (err,user) =>{
        if(err){
            return res.status(403).json({ status: 'error', message: 'Invalid or expired token' });
        }
        req.user = user;
        // next();
    });

};

module.exports = authenticateJWT;