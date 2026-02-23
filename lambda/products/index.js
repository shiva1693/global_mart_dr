exports.handler = async (event) => {
    console.log("Products service invoked");

    return {
        statusCode: 200,
        headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
        },
        body: JSON.stringify({
            service: "products",
            region: process.env.AWS_REGION,
            env: process.env.APP_ENV
        })
    };
};