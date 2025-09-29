export const responseUrl = (res: any) => {
    const console = {
        url: res.url,
        status: res.status,
        body: res.body,
        headers: res.headers,
        statusText: res.statusText
    };

    return console;
}