import logging

def main(req):
    logging.info('Azure Function triggered by Event Grid')
    return "Processed!"
